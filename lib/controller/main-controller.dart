import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:group/models/theme.dart';
import 'package:group/database/database.dart';

class MainController extends GetxController {
  static final AppDatabase _cache = AppDatabase.instance;

  @override
  void onInit() async {
    super.onInit();
    print('MAIN');
  }

  updateLocale(Locale locale) async {
    Get.updateLocale(locale);
    await _cache.setLocale(locale);
  }

  SelectTheme get theme => SelectTheme(() async {
        await _cache.setTheme('light');
        Get.changeTheme(AppTheme.lightTheme);
      }, () async {
        await _cache.setTheme('dark');
        Get.changeTheme(AppTheme.darkTheme);
      }, () async {
        await _cache.setTheme('personalized');
        Get.changeTheme(AppTheme.personalizedTheme);
      });
}
