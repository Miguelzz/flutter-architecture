import 'dart:async';
import 'package:flutter_architecture/app/data/database/database.dart';
import 'package:flutter_architecture/app/config/theme/dark.dart';
import 'package:flutter_architecture/app/config/theme/custom.dart';
import 'package:flutter_architecture/app/config/theme/light.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';

class DataPreloaded {
  static final AppDatabase _db = Get.find<AppDatabase>();
  static final Connectivity _connectivity = Connectivity();
  static late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  static bool useMock = false;
  static bool connection = false;

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

    await _initConnectivity();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);

    switch (await _db.getTheme()) {
      case 'dark':
        theme = darkTheme;
        break;
      case 'custom':
        theme = customTheme;
        break;
      default:
        theme = lightTheme;
        break;
    }
  }

  static Future<void> _initConnectivity() async {
    ConnectivityResult? result;
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      print(e.toString());
    }
    _updateConnectionStatus(result);
  }

  static void _updateConnectionStatus(ConnectivityResult? result) {
    switch (result) {
      case ConnectivityResult.wifi:
      case ConnectivityResult.mobile:
        connection = true;
        break;
      default:
        connection = false;
        break;
    }
  }

  close() {
    _connectivitySubscription.cancel();
  }
}
