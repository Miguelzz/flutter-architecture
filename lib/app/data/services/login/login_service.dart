import 'package:flutter_architecture/app/config/constants.dart';
import 'package:flutter_architecture/app/data/models/token.dart';
import 'package:flutter_architecture/app/data/services/login/login_gateway.dart';
import 'package:flutter_architecture/app/config/app_interceptor.dart';
import 'package:get/get.dart';

import 'package:flutter_architecture/app/data/database/database.dart';

class LoginService extends LoginGateway {
  static final AppInterceptor _http = Get.find<AppInterceptor>();
  static final auth = '${Constants.IDENTITY}/auth';
  static final AppDatabase _db = Get.find<AppDatabase>();

  @override
  Future<bool> login(String prefix, String phone, String message) async {
    final result = _http.post(url: '$auth/login', data: {
      'prefix': prefix,
      'phone': phone,
      'message': message,
    });
    result.showMessage('Validando...');
    return result.mapType<bool>();
  }

  @override
  Future<Token> validateLogin(String prefix, String phone, String code) async {
    final result = _http.post(url: '$auth/validate-login', data: {
      'prefix': prefix,
      'phone': phone,
      'code': code,
    });
    result.showMessage('Verificando...');
    return result.mapEntity<Token>();
  }

  @override
  Future<Token> resetToken() async {
    final user = await _db.getUser();
    final previousCode = await _db.getPreviousCode();

    final result = _http.post(url: '$auth/reset-token', data: {
      'prefix': user?.prefix,
      'phone': user?.phone,
      'code': previousCode
    });

    return result.mapEntity<Token>();
  }
}
