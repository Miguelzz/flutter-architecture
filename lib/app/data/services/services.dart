import 'package:get/get.dart';
import 'package:group/app/data/models/request_token.dart';
import 'package:group/app/data/models/user.dart';
import 'package:group/app/utils/interceptors.dart';

class Services {
  static final ServiceCache _http = Get.find<ServiceCache>();
  static final mockapi = 'https://606ce51b603ded0017502c35.mockapi.io/api';
  static final jsonplaceholder = 'https://jsonplaceholder.typicode.com';
  static final identity = 'https://identityapptest.herokuapp.com/api';

  Stream<User?> getUser(String id) => _http.get<User>(
        url: '$jsonplaceholder/users/$id',
        cache: TypeCache.TEMPORARY,
      );

  Stream<User?> login(String prefix, String phone) => _http.post<User>(
          url: '$identity/auth/login',
          cache: TypeCache.INTERNET,
          data: {
            'prefix': prefix,
            'phone': phone,
            'message': 'Welcome to architecture verification code [code]'
          });

  Stream<RequestToken?> login2(String prefix, String phone) =>
      _http.get<RequestToken>(
        url: '$mockapi/user/tokens/1',
        cache: TypeCache.INTERNET,
      );
  //;
}
//https://identityapptest.herokuapp.com/api/auth/login
////
