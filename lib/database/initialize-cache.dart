import 'package:myArchitecture/database/database.dart';
import 'package:myArchitecture/models/user.dart';
import 'package:myArchitecture/services/manager.dart';

class InitializeCache {
  static final InitializeCache _singleton = InitializeCache._internal();
  factory InitializeCache() => _singleton;
  static InitializeCache get instance => _singleton;
  static final AppDatabase _database = AppDatabase.instance;
  InitializeCache._internal();

  late String route;
  late String theme;
  late String token;
  late bool authenticated;

  Future<void> init() async {
    route = (await _database.getDB('route')) ?? '/splash';
    theme = (await _database.getDB('theme')) ?? 'light';
    token = (await _database.getDB('token')) ?? '';
    authenticated = (await _database.getDB('authenticated')) ?? false;

    if (!authenticated) route = 'login';

    await ManagerService.instance.init();
  }

  static final user = User(id: 7, age: 29, name: 'new user').toJson();
  static final other = User(id: 7, age: 29, name: 'new user').toJson();
}
