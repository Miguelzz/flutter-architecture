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
    await offAllTerms();
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

  Future<void> offAllHome() async => await _offAllNamedRoute('/');

  Future<void> nexSetting() async => await _nexRouteNoSave('/setting');
  Future<void> nexProfile() async => await _nexRouteNoSave('/profile');

  Future<void> offAllTerms() async => await _offAllNamedRoute('/terms');
  Future<void> nexReadTerms() async => await _nexRouteNoSave('/read-terms');
  Future<void> nexNumber() async => await _nexRouteNoSave('/validate-number');
  Future<void> nexValidateCode() async =>
      await _nexRouteNoSave('/validate-code');
  Future<void> offAllUserInfo() async => await _offAllNamedRoute('/user-info');

  Future<void> nexNone() async => await _nexRouteNoSave('/none');

  @override
  void onInit() async {
    super.onInit();
    print('ROUTES');
  }
}
