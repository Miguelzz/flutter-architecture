import 'dart:async';
import 'package:country_picker/country_picker.dart';
import 'package:flutter_architecture/app/config/app_events.dart';
import 'package:flutter_architecture/app/data/services/login/login_service.dart';
import 'package:flutter_architecture/app/data/services/users/user_service.dart';
import 'package:get/get.dart';
import 'package:flutter_architecture/app/data/database/database.dart';
import 'package:flutter_architecture/app/routes/routes_controller.dart';

class LoginController extends GetxController {
  static final AppDatabase _db = Get.find<AppDatabase>();
  static final LoginService _loginService = Get.find<LoginService>();
  static final UserService _userService = Get.find<UserService>();
  static final RouteController route = Get.find();

  String country = 'Colombia';
  String codePhone = '57';
  String phone = '';

  changePhone(String value) {
    phone = value;
    update();
  }

  changeCountry(Country value) {
    country = value.name;
    codePhone = value.phoneCode;
    update();
  }

  Future<void> validateNumber() async {
    print('validate');
    await _loginService.login(codePhone, phone, 'code [code]');
    route.nexValidateCode();
  }

  Future<void> validateCode(String code) async {
    final token = await _loginService.validateLogin(codePhone, phone, code);
    await _db.setPreviousCode(code);
    await EventsApp.changueToken(token);

    final user = await _userService.getUser();
    await EventsApp.changueUser(user);

    await route.offAllUserInfo();
  }

  @override
  void onInit() async {
    super.onInit();

    print('LOGIN');
  }
}
