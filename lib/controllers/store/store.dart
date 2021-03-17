import 'dart:async';
import 'package:get/get.dart';
import 'package:myArchitecture/controllers/database/database.dart';
import 'package:myArchitecture/controllers/store/theme.dart';
import 'package:sembast/sembast.dart';

class Store {
  Store._internal();

  static Store _instance = Store._internal();
  static Store get instance => _instance;

  final StoreRef _store = StoreRef.main();
  static Database _db;

  Future<void> init() async {
    _db = await AppDatabase.instance.database;
    final theme = (await _store.record('theme').get(_db)) ?? 'light';
    _initTheme(theme);

    _route = (await _store.record('route').get(_db)) ?? 'login';
  }

  String _route;
  String get route => _route;

  Future<void> setRoute(String value) async =>
      await _store.record('route').put(_db, value);

  Future<void> setTheme(String value) async =>
      await _store.record('theme').put(_db, value);

  void _initTheme(String value) {
    switch (value) {
      case 'light':
        Get.changeTheme(Theme.lightTheme);
        break;
      case 'dark':
        Get.changeTheme(Theme.darkTheme);
        break;
      case 'debtor':
        Get.changeTheme(Theme.debtorTheme);
        break;
    }
  }
}
