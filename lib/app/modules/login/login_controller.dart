import 'dart:async';
import 'package:flutter_architecture/app/config/app_events.dart';
import 'package:flutter_architecture/app/data/services/login/login_service.dart';
import 'package:flutter_architecture/app/data/services/users/user_service.dart';
import 'package:get/get.dart';
import 'package:flutter_architecture/app/data/database/database.dart';

class LoginController extends GetxController {
  static final AppDatabase _db = Get.find<AppDatabase>();
  static final LoginService _loginService = Get.find<LoginService>();
  static final UserService _userService = Get.find<UserService>();

  String country = 'Colombia';
  String codePhone = '57';
  String phone = '';
  String code = '';

  changeCodePhone(String value) {
    codePhone = value;
    update();
  }

  changePhone(String value) {
    phone = value;
    update();
  }

  changeCode(String value) {
    code = value;
  }

  changeCountry(String value) {
    country = value;
    update();
  }

  Future<void> login() async {
    await EventsApp.dialogLoading<bool>('Validando...', () async {
      return await _loginService.login(codePhone, phone, 'code [code]').first;
    });

    Get.toNamed('/validate-login');
  }

  Future<void> validateLogin() async {
    await _db.setPreviousCode(code);
    final token = await EventsApp.dialogLoading('Verificando...', () async {
      return await _loginService.validateLogin(codePhone, phone, code).first;
    });

    await EventsApp.changueToken(token);
    Get.offAllNamed('/');
    await _db.setRoute('/');
    final user = await _userService.getUser().first;
    await EventsApp.changueUser(user);
  }

  @override
  void onInit() async {
    super.onInit();

    print('LOGIN');
  }
}
