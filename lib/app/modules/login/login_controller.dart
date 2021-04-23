import 'dart:async';
import 'package:flutter_architecture/app/config/app_events.dart';
import 'package:flutter_architecture/app/data/database/data-preloaded.dart';
import 'package:flutter_architecture/app/data/services/login/login_service.dart';
import 'package:flutter_architecture/app/data/services/users/user_service.dart';
import 'package:get/get.dart';
import 'package:flutter_architecture/app/data/database/database.dart';
import 'package:flutter_architecture/app/data/models/user.dart';

class LoginController extends GetxController {
  static final AppDatabase _db = Get.find<AppDatabase>();
  static final LoginService _loginService = Get.find<LoginService>();
  static final UserService _userService = Get.find<UserService>();

  Future<void> login({required String prefix, required String phone}) async {
    await EventsApp.changueUser(User(prefix: prefix, phone: phone));
    await _loginService.login(prefix, phone, 'code [code]').first;
    Get.toNamed('/validate-login');
  }

  Future<void> validateLogin({required String code}) async {
    try {
      final token = await _loginService
          .validateLogin(EventsApp.user.prefix!, EventsApp.user.phone!, code)
          .first;

      await _db.setPreviousCode(code);
      await EventsApp.changueToken(token);

      final user = await _userService.getUser().first;
      await EventsApp.changueUser(user);

      Get.offAllNamed('/');
      await _db.setRoute('/');
    } catch (e) {
      Get.toNamed('/login');
    }
  }

  @override
  void onInit() async {
    super.onInit();

    print('LOGIN');
  }
}
