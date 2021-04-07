import 'package:get/get.dart';
import 'package:group/app/data/models/request_token.dart';
import 'package:group/app/data/models/user.dart';
import 'package:group/app/utils/interceptors.dart';

class Services {
  static final ServiceCache _http = Get.find<ServiceCache>();
  static final mockapi = 'https://606ce51b603ded0017502c35.mockapi.io/api';
  static final jsonplaceholder = 'https://jsonplaceholder.typicode.com';
  static final local = 'http://172.30.240.1:4000';

  Stream<User?> getUser(String id) => _http.get<User>(UrlCache(
        base: jsonplaceholder,
        url: '/users/$id',
        cache: TypeCache.TEMPORARY,
        mock: User(id: 15, name: 'Miguel', age: 29, completed: false),
      ));

  Stream<RequestToken?> login(String prefix, String phone) =>
      _http.get<RequestToken>(UrlCache(
        base: mockapi,
        url: '/user/tokens/1',
        cache: TypeCache.INTERNET,
        mock: RequestToken(
            expiresAt: DateTime.parse('2021-09-24T03:57:08.568Z'),
            requestToken:
                'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJtZXNzYWdlIjoiSldUIFJ1bGVzISIsImlhdCI6MTQ1OTQ0ODExOSwiZXhwIjoxNDU5NDU0NTE5fQ.-yIVBD5b73C75osbmwwshQNRC7frWUYrqaTjTpza2y4',
            success: true),
      ));
  //data: {'prefix': prefix, 'phone': phone});
}
