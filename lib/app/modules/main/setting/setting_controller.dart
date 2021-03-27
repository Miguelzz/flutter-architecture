import 'package:flutter/painting.dart';
import 'package:get/get.dart';
import 'package:group/app/data/database/database.dart';
import 'package:group/app/theme/theme.dart';
import 'package:group/app/data/services/services.dart';

class SettingController extends GetxController {
  static final Services _services = Services.instance;
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
