import 'dart:async';
import 'package:get/get.dart';
import 'package:myArchitecture/controller/theme.dart';
import 'package:myArchitecture/database/database.dart';
import 'package:myArchitecture/database/initialize-cache.dart';

class MainController extends GetxController {
  static final AppDatabase _cache = AppDatabase.instance;

  @override
  void onInit() async {
    super.onInit();
    _initTheme(InitializeCache.instance.theme);
  }

  Future<void> autenticate(bool auth) async {
    await _cache.setDB('authenticated', auth);
  }

  Future<void> route(String route, {dynamic arguments}) async {
    Get.toNamed(route, arguments: arguments);
    if (route == '/login') {
      await _cache.setDB('authenticated', false);
    }
    await _cache.setDB('route', route);
  }

  Future<void> theme(String value) async => await _cache.setDB('theme', value);

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
