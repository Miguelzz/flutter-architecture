import 'package:flutter_architecture/app/config/constants.dart';
import 'package:flutter_architecture/app/data/services/users/user_gateway.dart';
import 'package:flutter_architecture/app/data/models/user.dart';
import 'package:flutter_architecture/app/config/interceptors.dart';
import 'package:get/get.dart';

class UserService extends UserGateway {
  static final ServiceTemporary _http = Get.find<ServiceTemporary>();
  static final identity = Constants.IDENTITY;

  @override
  Stream<User> getUser() => _http.get<User>(url: '$identity/user');

  @override
  Stream<User> updateNames(String names) =>
      _http.put<User>(url: '$identity/user/names', data: {'names': names});

  @override
  Stream<User> updateSurnames(String surnames) => _http
      .put<User>(url: '$identity/user/surnames', data: {'surnames': surnames});

  @override
  Stream<User> updateAddress(String address) => _http
      .put<User>(url: '$identity/user/address', data: {'address': address});

  @override
  Stream<User> updateBirthday(String birthday) => _http
      .put<User>(url: '$identity/user/birthday', data: {'birthday': birthday});

  @override
  Stream<User> updateEmail(String email) =>
      _http.put<User>(url: '$identity/user/email', data: {'email': email});
}
