import 'dart:async';
import 'package:get/get.dart';
import 'package:group/database/database.dart';

class RouteController extends GetxController {
  static final AppDatabase _cache = AppDatabase.instance;

  Future<void> login(String prefix, String phone) async {
    await _cache.setDB('token', 'dkjashdjkhsa');
    await _cache.setRoute('/');
    Get.offAllNamed('/');
  }

  Future<void> _nexRoute(String route) async {
    Get.toNamed(route);
    await _cache.setRoute(route);
  }

  Future<void> _offAllNamedRoute(String route) async {
    Get.offAllNamed(route);
    await _cache.setRoute(route);
  }

  Future<void> nexBack() async {
    print('**********');
    print('|${Get.previousRoute}|');
    print('**********');
    if (Get.previousRoute.trim() == '') offAllHome();
    Get.back();
  }

  Future<void> nexSplash() async {
    Get.offAllNamed('/splash');
    await _cache.setRoute('/login');
  }

  Future<void> nexHome() async => _nexRoute('/');
  Future<void> offAllHome() async => _offAllNamedRoute('/');

  Future<void> nexRegister() async => _nexRoute('/register');
  Future<void> nexRegisterStep2() async => _nexRoute('/register/step2');
  Future<void> nexRegisterStep3() async => _nexRoute('/register/step3');

  Future<void> nexPageStep2() async => _nexRoute('/page/step2');
  Future<void> nexPageStep3() async => _nexRoute('/page/step3');

  @override
  void onInit() async {
    super.onInit();

    print('LOGIN');
  }
}
