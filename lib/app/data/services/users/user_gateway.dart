import 'package:flutter_architecture/app/data/models/user.dart';

abstract class UserGateway {
  Stream<User> getUser();
  Stream<User> updateUser(User user);
  Stream<bool> deleteUser();
}
