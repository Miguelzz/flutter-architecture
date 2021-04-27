import 'package:flutter_architecture/app/config/constants.dart';
import 'package:flutter_architecture/app/data/models/token.dart';
import 'package:flutter_architecture/app/data/services/login/login_gateway.dart';
import 'package:flutter_architecture/app/config/app_interceptor.dart';
import 'package:flutter_architecture/app/config/app_events.dart';
import 'package:get/get.dart';

import 'package:flutter_architecture/app/data/database/database.dart';

class LoginService extends LoginGateway {
  static final AppInterceptor _http = Get.find<AppInterceptor>();
  static final identity = Constants.IDENTITY;
  static final AppDatabase _db = Get.find<AppDatabase>();

  @override
  Future<bool> login(String prefix, String phone, String message) {
    return _http.post<bool>(url: '$identity/auth/login', data: {
      'prefix': prefix,
      'phone': phone,
      'message': message,
    });
  }

  @override
  Future<Token> validateLogin(String prefix, String phone, String code) {
    return _http.post<Token>(url: '$identity/auth/validate-login', data: {
      'prefix': prefix,
      'phone': phone,
      'code': code,
    });
  }

  @override
  Future<Token> resetToken() async {
    final user = await _db.getUser();
    final previousCode = await _db.getPreviousCode();
    return _http.post<Token>(url: '$identity/auth/reset-token', data: {
      'prefix': user?.prefix,
      'phone': user?.phone,
      'code': previousCode
    });
  }
}
