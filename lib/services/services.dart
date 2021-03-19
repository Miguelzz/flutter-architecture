import 'package:myArchitecture/models/user.dart';
import 'package:myArchitecture/services/interceptors.dart';

class Services {
  Services._internal();
  static Services _singleton = Services._internal();
  static Services get instance => _singleton;
  final http = ServiceCache.instance;

  Future<User> getUsers({bool useCache = false}) async =>
      User.fromJson(await http.get(useCache, 'user', 'users/2'));
}
