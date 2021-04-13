import 'package:flutter_architecture/app/data/services/users/user_gateway.dart';
import 'package:flutter_architecture/app/data/models/user.dart';
import 'package:flutter_architecture/app/utils/interceptors.dart';
import 'package:get/get.dart';

class UserService extends UserGateway {
  static final ServiceTemporary _http = Get.find<ServiceTemporary>();
  static final identity = 'https://identityapptest.herokuapp.com/api';

  @override
  Stream<User> getUser() {
    return _http.get<User>(url: '$identity/users/me');
  }

  @override
  Stream<bool> deleteUser() {
    throw UnimplementedError();
  }

  @override
  Stream<User> updateUser(User user) {
    throw UnimplementedError();
  }
}
