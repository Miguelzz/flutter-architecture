import 'package:flutter/painting.dart';
import 'package:get/get.dart';
import 'package:flutter_architecture/app/data/database/database.dart';
import 'package:flutter_architecture/app/theme/theme.dart';

class SettingController extends GetxController {
  static final AppDatabase _db = Get.find<AppDatabase>();

  updateLocale(Locale locale) async {
    Get.updateLocale(locale);
    await _db.setLocale(locale);
  }

  SelectTheme get theme => SelectTheme(() async {
        Get.changeTheme(AppTheme.lightTheme);
        await _db.setTheme('light');
      }, () async {
        Get.changeTheme(AppTheme.darkTheme);
        await _db.setTheme('dark');
      }, () async {
        Get.changeTheme(AppTheme.customTheme);
        await _db.setTheme('custom');
      });

  @override
  void onInit() async {
    super.onInit();
    print('SETTINGS');
  }
}
