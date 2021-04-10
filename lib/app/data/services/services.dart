import 'package:get/get.dart';
import 'package:group/app/data/models/token.dart';
import 'package:group/app/data/models/user.dart';
import 'package:group/app/utils/interceptors.dart';

class Services {
  static final ServiceCache _http = Get.find<ServiceCache>();

  // 'http://localhost:4000/api'
  static final identity = 'https://identityapptest.herokuapp.com/api';

  Stream<User> me() => _http.get<User>(url: '$identity/users/me', cache: true);

  Stream<User> login(String prefix, String phone, String message) =>
      _http.post<User>(
          url: '$identity/auth/login',
          data: {'prefix': prefix, 'phone': phone, 'message': message});

  Stream<Token> validateLogin(String prefix, String phone, String code) =>
      _http.post<Token>(
          url: '$identity/auth/validate-login',
          data: {'prefix': prefix, 'phone': phone, 'code': code});
}
