import 'package:get/get.dart';
import 'package:group/app/data/models/user.dart';
import 'package:group/app/utils/interceptors.dart';

class Services {
  static final ServiceCache _http = Get.find<ServiceCache>();
  static final jsonplaceholder = 'https://jsonplaceholder.typicode.com';
  static final local = 'http://172.30.240.1:4000';

  Stream<User?> getUser(String id) => _http.get<User>(UrlCache(
        base: jsonplaceholder,
        url: '/users/$id',
        cache: TypeCache.TEMPORARY,
        mock: User(id: 15, name: 'Miguel', age: 29, completed: false),
      ));

  Stream<String?> login(String prefix, String phone) => _http.post<String>(
      UrlCache(
        base: jsonplaceholder,
        url: '/user/token',
        cache: TypeCache.INTERNET,
        mock:
            'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJtZXNzYWdlIjoiSldUIFJ1bGVzISIsImlhdCI6MTQ1OTQ0ODExOSwiZXhwIjoxNDU5NDU0NTE5fQ.-yIVBD5b73C75osbmwwshQNRC7frWUYrqaTjTpza2y4',
      ),
      data: {'prefix': prefix, 'phone': phone});
}
