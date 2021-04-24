import 'package:flutter/painting.dart';
import 'package:get/get.dart';
import 'package:flutter_architecture/app/data/database/database.dart';
import 'package:flutter_architecture/app/config/theme/dark.dart';
import 'package:flutter_architecture/app/config/theme/light.dart';
import 'package:flutter_architecture/app/config/app_events.dart';
import 'package:flutter_architecture/app/data/models/user.dart';

class SettingController extends GetxController {
  static final AppDatabase _db = Get.find<AppDatabase>();

  User user = EventsApp.user;
  bool theme = true;

  updateTheme(bool value) async {
    theme = value;
    if (value) {
      Get.changeTheme(lightTheme);
      await _db.setTheme('light');
    } else {
      Get.changeTheme(darkTheme);
      await _db.setTheme('dark');
    }
    update();
  }

  updateLocale(String locale) async {
    switch (locale) {
      case 'es':
        Get.updateLocale(Locale('es', 'CO'));
        await _db.setLocale(Locale('es', 'CO'));
        break;

      case 'en':
        Get.updateLocale(Locale('en', 'US'));
        await _db.setLocale(Locale('en', 'US'));
        break;
    }
  }

  @override
  void onInit() async {
    super.onInit();
    EventsApp.user$.listen((value) {
      user = value;
      update();
    });
    print('SETTINGS');
  }
}
