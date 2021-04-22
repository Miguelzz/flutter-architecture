import 'package:flutter_architecture/app/data/models/user.dart';

abstract class UserGateway {
  Stream<User> getUser();
  Stream<User> updateNames(String names);
  Stream<User> updateSurnames(String surnames);
  Stream<User> updateEmail(String email);
  Stream<User> updateAddress(String address);
  Stream<User> updateBirthday(String birthday);
}
