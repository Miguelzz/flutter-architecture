import 'dart:async';
import 'package:flutter_architecture/app/data/database/data-preloaded.dart';
import 'package:flutter_architecture/app/data/models/message_error.dart';
import 'package:flutter_architecture/app/data/services/login/login_service.dart';
import 'package:get/get.dart';
import 'package:flutter_architecture/app/data/database/database.dart';
import 'package:flutter_architecture/app/config/interceptors.dart';

import '../data/models/token.dart';
import '../routes/routes_controller.dart';

class Orchestrator {
  static final AppDatabase _db = Get.find<AppDatabase>();
  static final LoginService _loginService = Get.find<LoginService>();

  static void _cleanRecents() {
    Timer.periodic(Duration(seconds: 5), (timer) {
      ServiceTemporary.recentPost = ServiceTemporary.recentPost
          .where((x) => DateTime.now().difference(x.date).inSeconds <= 3)
          .toList();
      ServiceTemporary.recentPut = ServiceTemporary.recentPut
          .where((x) => DateTime.now().difference(x.date).inSeconds <= 3)
          .toList();
      ServiceTemporary.recentGet = ServiceTemporary.recentGet
          .where((x) => DateTime.now().difference(x.date).inSeconds <= 3)
          .toList();
    });
  }

  static void _clearTemporary() {
    Timer.periodic(Duration(days: 1), (timer) async {
      final filter = (await _db.getTemporary())
          .where((x) => DateTime.now().difference(x.date).inDays <= 2)
          .toList();
      await _db.resetTemporary(filter);
    });
  }

  static Future<void> _resetToken() async {
    // resetToken

    final routes = [
      '/register',
      '/register/step2',
      '/register/step3',
      '/splash',
      '/login',
      '/validate-login',
    ];

    bool wait = false;
    Timer.periodic(Duration(seconds: 1), (timer) async {
      final expiresAt = (DataPreloaded.token.expiresAt ?? DateTime.now())
          .difference(DateTime.now())
          .inSeconds;

      await _db.setToken(Token().fromJson(
          {'token': DataPreloaded.token.token, 'expiresAt': expiresAt})!);

      if (!wait &&
          expiresAt <= 15 &&
          !routes.any((x) => Get.currentRoute == x)) {
        print('Reset Token');
        wait = true;
        try {
          final token = await _loginService
              .resetToken(
                DataPreloaded.user.prefix!,
                DataPreloaded.user.phone!,
                DataPreloaded.previousCode,
              )
              .first;
          print(token.toJson());
          await _db.setToken(token);
        } on MessageError catch (e) {
          final RouteController _route = Get.find();
          await _route.logout();
        }
        wait = false;
      }
    });
  }

  static void _updateRoute() {
    Timer.periodic(Duration(seconds: 5), (timer) {
      final previos = Get.currentRoute;
      if (Get.previousRoute.trim() == '') Get.offAllNamed('/');
      _db.setRoute(previos);
    });
  }

  static Future<void> init() async {
    _clearTemporary();
    _cleanRecents();
    _resetToken();
    _updateRoute();
  }
}
