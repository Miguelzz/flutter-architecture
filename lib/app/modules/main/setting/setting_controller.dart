import 'package:flutter/painting.dart';
import 'package:get/get.dart';
import 'package:flutter_architecture/app/data/database/database.dart';
import 'package:flutter_architecture/app/config/theme/dark.dart';
import 'package:flutter_architecture/app/config/theme/custom.dart';
import 'package:flutter_architecture/app/config/theme/light.dart';
import 'package:flutter_architecture/app/config/theme/theme.dart';

class SettingController extends GetxController {
  static final AppDatabase _db = Get.find<AppDatabase>();

  updateLocale(Locale locale) async {
    Get.updateLocale(locale);
    await _db.setLocale(locale);
  }

  SelectTheme get theme => SelectTheme(() async {
        Get.changeTheme(lightTheme);
        await _db.setTheme('light');
      }, () async {
        Get.changeTheme(darkTheme);
        await _db.setTheme('dark');
      }, () async {
        Get.changeTheme(customTheme);
        await _db.setTheme('custom');
      });

  @override
  void onInit() async {
    super.onInit();
    print('SETTINGS');
  }
}
