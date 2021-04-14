import 'package:flutter_architecture/app/config/constants.dart';
import 'package:flutter_architecture/app/data/models/token.dart';
import 'package:flutter_architecture/app/data/services/login/login_gateway.dart';
import 'package:flutter_architecture/app/config/interceptors.dart';
import 'package:get/get.dart';

class LoginService extends LoginGateway {
  static final ServiceTemporary _http = Get.find<ServiceTemporary>();
  static final identity = Constants.IDENTITY;

  @override
  Stream<bool> login(String prefix, String phone, String message) {
    return _http.post<bool>(
        url: '$identity/auth/login',
        data: {'prefix': prefix, 'phone': phone, 'message': message});
  }

  @override
  Stream<Token> validateLogin(String prefix, String phone, String code) {
    return _http.post<Token>(
        url: '$identity/auth/validate-login',
        data: {'prefix': prefix, 'phone': phone, 'code': code});
  }

  @override
  Stream<Token> resetToken(String prefix, String phone, String code) {
    return _http.post<Token>(
        url: '$identity/auth/reset-token',
        data: {'prefix': prefix, 'phone': phone, 'code': code});
  }
}
