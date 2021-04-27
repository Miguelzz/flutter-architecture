import 'package:flutter_architecture/app/config/constants.dart';
import 'package:flutter_architecture/app/data/services/users/user_gateway.dart';
import 'package:flutter_architecture/app/data/models/user.dart';
import 'package:flutter_architecture/app/config/app_interceptor.dart';
import 'package:get/get.dart';

class UserService extends UserGateway {
  static final AppInterceptor _http = Get.find<AppInterceptor>();
  static final identity = Constants.IDENTITY;

  @override
  Future<User> getUser() => _http.get<User>(url: '$identity/user');

  @override
  Future<User> updateNames(String names) =>
      _http.put<User>(url: '$identity/user/names', data: {'names': names});

  @override
  Future<User> updateSurnames(String surnames) => _http
      .put<User>(url: '$identity/user/surnames', data: {'surnames': surnames});

  @override
  Future<User> updateAddress(String address) => _http
      .put<User>(url: '$identity/user/address', data: {'address': address});

  @override
  Future<User> updateBirthday(String birthday) => _http
      .put<User>(url: '$identity/user/birthday', data: {'birthday': birthday});

  @override
  Future<User> updateEmail(String email) =>
      _http.put<User>(url: '$identity/user/email', data: {'email': email});
}
