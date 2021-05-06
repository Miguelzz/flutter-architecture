import 'dart:async';
import 'package:flutter_architecture/app/data/database/database.dart';
import 'package:flutter_architecture/app/config/theme/dark.dart';
import 'package:flutter_architecture/app/config/theme/light.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:get/get.dart';

class DataPreloaded {
  static final AppDatabase _db = Get.find<AppDatabase>();

  static bool useMock = false;
  static late String route;
  static late ThemeData theme;
  static late Locale locale;

  static Future<void> init() async {
    locale = (await _db.getLocale()) ?? Locale('es');

    final getRoute = await _db.getRoute();

    if (getRoute == '/user-info')
      route = '/user-info';
    else if ((await _db.getPreviousCode()) == null || getRoute == null) {
      route = '/terms';
    } else
      route = getRoute;

    switch (await _db.getTheme()) {
      case 'dark':
        theme = darkTheme;
        break;
      // case 'custom':
      //   theme = customTheme;
      //   break;
      default:
        theme = lightTheme;
        break;
    }
  }
}
