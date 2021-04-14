import 'dart:async';

import 'package:flutter_architecture/app/data/models/message_error.dart';
import 'package:flutter_architecture/app/data/models/token.dart';
import 'package:flutter_architecture/app/data/database/database.dart';
import 'package:flutter_architecture/app/data/models/user.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter_architecture/app/config/theme.dart';

class DataPreloaded {
  static final AppDatabase _db = Get.find<AppDatabase>();
  static final Connectivity _connectivity = Connectivity();
  static late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  static late bool useMock;
  static late String route, previousCode;
  static late Token token;
  static late ThemeData theme;
  static late Locale locale;
  static late bool connection;
  static late User user;

  static Future<void> init() async {
    useMock = false;
    connection = false;
    locale = (await _db.getLocale()) ?? Locale('en', 'CO');
    route = (await _db.getRoute()) ?? '/splash';
    user = (await _db.getUser()) ?? User();
    token = (await _db.getToken()) ?? Token();
    previousCode = (await _db.getPreviousCode()) ?? '0';

    await _initConnectivity();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);

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