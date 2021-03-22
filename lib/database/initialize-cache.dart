import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:group/database/database.dart';
import 'package:group/services/manager.dart';
import 'package:group/models/theme.dart';

class InitializeCache {
  static final InitializeCache _singleton = InitializeCache._internal();
  factory InitializeCache() => _singleton;
  static InitializeCache get instance => _singleton;
  static final AppDatabase _database = AppDatabase.instance;
  InitializeCache._internal();

  late bool useMock;
  late String route;
  late ThemeData theme;
  late String token;
  late Locale locale;

  Future<void> init({bool useMock = false}) async {
    this.useMock = useMock;
    locale = (await _database.getLocale()) ?? Locale('en', 'CO');
    route = (await _database.getRoute()) ?? '/splash';
    token = (await _database.getToken()) ?? '';
    await ManagerService.instance.init();

    switch ((await _database.getTheme()) ?? 'light') {
      case 'light':
        theme = AppTheme.lightTheme;
        break;
      case 'dark':
        theme = AppTheme.darkTheme;
        break;
      case 'personalized':
        theme = AppTheme.personalizedTheme;
        break;
    }
  }
}
