import 'package:flutter_architecture/app/config/constants.dart';
import 'package:flutter_architecture/app/data/services/users/user_gateway.dart';
import 'package:flutter_architecture/app/data/models/user.dart';
import 'package:flutter_architecture/app/config/app_interceptor.dart';
import 'package:get/get.dart';

class UserService extends UserGateway {
  static final AppInterceptor _http = Get.find<AppInterceptor>();
  static final user = '${Constants.IDENTITY}/user';

  @override
  Future<User> getUser() async {
    final result = _http.get(url: '$user');
    return result.mapEntity<User>();
  }

  @override
  Future<User> updateNames(String names) async {
    final result = _http.put(url: '$user/names', data: {'names': names});

    return result.mapEntity<User>();
  }

  @override
  Future<User> updateSurnames(String surnames) async {
    final result =
        _http.put(url: '$user/surnames', data: {'surnames': surnames});

    return result.mapEntity<User>();
  }

  @override
  Future<User> updateAddress(String address) async {
    final result = _http.put(url: '$user/address', data: {'address': address});

    return result.mapEntity<User>();
  }

  @override
  Future<User> updateBirthday(String birthday) async {
    final result =
        _http.put(url: '$user/birthday', data: {'birthday': birthday});

    return result.mapEntity<User>();
  }

  @override
  Future<User> updateEmail(String email) async {
    final result = _http.put(url: '$user/email', data: {'email': email});

    return result.mapEntity<User>();
  }
}
