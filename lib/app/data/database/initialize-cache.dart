import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:group/app/data/database/database.dart';
import 'package:group/app/theme/theme.dart';

class InitializeCache {
  static final InitializeCache _singleton = InitializeCache._internal();
  factory InitializeCache() => _singleton;
  static InitializeCache get instance => _singleton;
  static final AppDatabase _db = Get.find<AppDatabase>();
  InitializeCache._internal();

  late bool useMock;
  late String route;
  late ThemeData theme;
  late Locale locale;

  Future<void> init({bool useMock = false}) async {
    this.useMock = useMock;
    //await _database.clearCache();
    locale = (await _db.getLocale()) ?? Locale('en', 'CO');
    route = (await _db.getRoute()) ?? '/splash';

    switch (await _db.getTheme()) {
      case 'dark':
        theme = AppTheme.darkTheme;
        break;
      case 'custom':
        theme = AppTheme.customTheme;
        break;
      default:
        theme = AppTheme.lightTheme;
        break;
    }
  }
}
