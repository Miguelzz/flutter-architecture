import 'dart:async';
import 'package:get/get.dart';
import 'package:group/database/database.dart';

class LoginController extends GetxController {
  static final AppDatabase _cache = AppDatabase.instance;

  Future<void> login(String prefix, String phone) async {
    await _cache.setDB('token', 'dkjashdjkhsa');
    await _cache.setRoute('/');
    Get.offAllNamed('/');
  }

  @override
  void onInit() async {
    super.onInit();

    print('LOGIN');
  }
}
