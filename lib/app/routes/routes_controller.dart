import 'dart:async';
import 'package:get/get.dart';
import 'package:flutter_architecture/app/data/database/database.dart';
import 'package:flutter_architecture/app/routes/routes.dart';

class RouteController extends GetxController {
  static final AppDatabase _db = Get.find<AppDatabase>();

  Future<void> logout() async {
    Get.offAllNamed('/login');
    await _db.deleteToken();
    await _db.deleteUser();
    await _db.deletePreviousCode();
    await _db.setRoute('/login');
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

  Future<void> nexHome() async => _nexRoute('/');
  Future<void> offAllHome() async => _offAllNamedRoute('/');

  Future<void> nexRegister() async => _nexRoute('/register');
  Future<void> nexRegisterStep2() async => _nexRoute('/register/step2');
  Future<void> nexRegisterStep3() async => _nexRoute('/register/step3');

  Future<void> nexSetting() async => _nexRoute('/setting');
  Future<void> nexProfile() async => _nexRoute('/profile');
  Future<void> nexNone() async => _nexRoute('/none');

  @override
  void onInit() async {
    super.onInit();
    print('ROUTES');
  }
}
