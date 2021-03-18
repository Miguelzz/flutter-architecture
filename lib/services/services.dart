import 'package:myArchitecture/models/user.dart';
import 'package:myArchitecture/services/interceptors.dart';

class Services {
  Services._internal();
  static Services _singleton = Services._internal();
  static Services get instance => _singleton;
  final http = ServiceCache.instance;

  Future<User> getUsers() async =>
      User.fromJson(await http.get('user', 'users/1'));
}
