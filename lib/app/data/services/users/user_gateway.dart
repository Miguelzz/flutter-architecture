import 'package:flutter_architecture/app/data/models/user.dart';

abstract class UserGateway {
  Future<User> getUser();
  Future<User> updateNames(String names);
  Future<User> updateSurnames(String surnames);
  Future<User> updateEmail(String email);
  Future<User> updateAddress(String address);
  Future<User> updateBirthday(String birthday);
}
