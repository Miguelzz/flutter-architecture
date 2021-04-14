import 'package:flutter_architecture/app/data/models/token.dart';

abstract class LoginGateway {
  Stream<bool> login(String prefix, String phone, String message);
  Stream<Token> validateLogin(String prefix, String phone, String code);
  Stream<Token> resetToken(String prefix, String phone, String code);
}
