import 'package:myArchitecture/models/user.dart';
import 'package:myArchitecture/services/interceptors.dart';

class Services {
  Services._internal();
  static Services _singleton = Services._internal();
  static Services get instance => _singleton;
  final http = ServiceCache.instance;

  HttpCache<User> getUser(String id) => http.get<User>('user', '/users/$id');
}
