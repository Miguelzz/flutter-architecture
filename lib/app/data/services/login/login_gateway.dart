import 'package:flutter_architecture/app/data/models/token.dart';

abstract class LoginGateway {
  Future<bool> login(String prefix, String phone, String message);
  Future<Token> validateLogin(String prefix, String phone, String code);
  Future<Token> resetToken();
}
