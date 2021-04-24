import 'dart:async';
import 'package:flutter_architecture/app/config/app_events.dart';
import 'package:flutter_architecture/app/data/models/token.dart';
import 'package:get/get.dart';
import 'package:flutter_architecture/app/data/database/database.dart';
import 'package:flutter_architecture/app/routes/routes.dart';

class RouteController extends GetxController {
  static final AppDatabase _db = Get.find<AppDatabase>();

  Future<void> logout() async {
    await _db.deleteToken();
    await _db.deleteUser();
    await _db.deletePreviousCode();
    await EventsApp.changueToken(Token());
    await nexTerms();
  }

  Future<void> _nexRoute(String name) async {
    String? route;
    try {
      route = routes.firstWhere((e) => e.name == name).name;
    } catch (e) {
      print('**********');
      print('|page $name no existe|');
      print('**********');
    }
    if (route != null) {
      Get.toNamed(route);
      await _db.setRoute(name);
    }
  }

  Future<void> _nexRouteNoSave(String name) async {
    String? route;
    try {
      route = routes.firstWhere((e) => e.name == name).name;
    } catch (e) {
      print('**********');
      print('|page $name no existe|');
      print('**********');
    }
    if (route != null) {
      Get.toNamed(route);
    }
  }

  Future<void> _offAllNamedRoute(String name) async {
    String? route;
    try {
      route = routes.firstWhere((e) => e.name == name).name;
    } catch (e) {
      print('***** ROUTE *****');
      print('|$name|');
      print('*****************');
    }
    if (route != null) {
      Get.offAllNamed(route);
      await _db.setRoute(name);
    }
  }

  Future<void> nexBack() async {
    if (Get.previousRoute.trim() == '')
      offAllHome();
    else
      Get.back();
  }

  Future<void> nexHome() async => await _nexRoute('/');
  Future<void> offAllHome() async => await _offAllNamedRoute('/');

  Future<void> nexSetting() async => await _nexRoute('/setting');
  Future<void> nexProfile() async => await _nexRoute('/profile');

  Future<void> nexTerms() async => await _offAllNamedRoute('/terms');
  Future<void> nexReadTerms() async => await _nexRouteNoSave('/read-terms');
  Future<void> nexNumber() async => await _nexRouteNoSave('/number');

  Future<void> nexNone() async => await _nexRouteNoSave('/none');

  @override
  void onInit() async {
    super.onInit();
    print('ROUTES');
  }
}
