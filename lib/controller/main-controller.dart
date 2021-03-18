import 'dart:async';
import 'package:get/get.dart';
import 'package:myArchitecture/controller/theme.dart';
import 'package:myArchitecture/database/database.dart';

class MainController extends GetxController {
  static AppDatabase _database = AppDatabase.instance;

  @override
  void onInit() async {
    super.onInit();
    _initTheme((await _database.getDB('theme')) ?? 'light');
    final authenticated = (await _database.getDB('authenticated')) ?? false;
    print('autenticado $authenticated');

    if (authenticated) {
      final route = (await _database.getDB('route')) ?? '/splash';
      Get.toNamed('$route', arguments: "Hello World!");
    } else {
      Get.toNamed('/splash', arguments: "Hello World!");
    }
  }

  Future<void> autenticate(bool auth) async {
    await _database.setDB('authenticated', auth);
  }

  Future<void> setRoute(String route, {dynamic arguments}) async {
    print(route);
    Get.toNamed(route, arguments: arguments);
    await _database.setDB('route', route);
  }

  Future<void> setTheme(String value) async =>
      await _database.setDB('theme', value);

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
