import 'package:group/app/data/models/user.dart';
import 'package:group/app/data/services/interceptors.dart';
import 'package:group/app/data/services/list_services.dart';

class Services {
  Services._internal();
  static Services _singleton = Services._internal();
  static Services get instance => _singleton;
  final _http = ServiceCache.instance;

  HttpCache<User?> getUser(String id) =>
      _http.get<User>(ListServices.urlUser('/users/$id'));

  HttpCache<User?> login() =>
      _http.get<User>(ListServices.login('/user/token'));
}
