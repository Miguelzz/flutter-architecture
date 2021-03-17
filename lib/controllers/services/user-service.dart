import 'package:myArchitecture/controllers/database/database.dart';
import 'package:myArchitecture/controllers/services/interceptors.dart';

import 'manager.dart';

class UserService {
  UserService._internal();
  static UserService _singleton = UserService._internal();
  static UserService get instance => _singleton;
  final http = Services.instance;
  final cache = AppDatabase.instance;

  dynamic getUsers() async {
    if (ManagerService.instance.connection) {
      try {
        final info = await http.get('https://api.currencyfreaks.com/');
        return info;
      } catch (e) {
        print('error ajax');
      }
    }
    //await cache.setDB('user', {"message": "Welcome to CurrencyFreaks CACHE"});
    final info = await cache.getDB('user');
    return info;
  }
}
