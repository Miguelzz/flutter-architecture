import 'package:flutter/painting.dart';
import 'package:get/get.dart';
import 'package:group/database/database.dart';
import 'package:group/models/theme.dart';
import 'package:group/services/services.dart';

class SettingController extends GetxController {
  static final Services _services = Services.instance;
  static final AppDatabase _cache = AppDatabase.instance;

  updateLocale(Locale locale) async {
    Get.updateLocale(locale);
    await _cache.setLocale(locale);
  }

  SelectTheme get theme => SelectTheme(() async {
        Get.changeTheme(AppTheme.lightTheme);
        await _cache.setTheme('light');
      }, () async {
        Get.changeTheme(AppTheme.darkTheme);
        await _cache.setTheme('dark');
      }, () async {
        Get.changeTheme(AppTheme.personalizedTheme);
        await _cache.setTheme('personalized');
      });

  @override
  void onInit() async {
    super.onInit();
    print('SETTINGS');
  }
}
