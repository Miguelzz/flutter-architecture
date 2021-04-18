import 'dart:async';
import 'package:flutter_architecture/app/data/database/data-preloaded.dart';
import 'package:flutter_architecture/app/data/models/message_error.dart';
import 'package:flutter_architecture/app/data/services/login/login_service.dart';
import 'package:get/get.dart';
import 'package:flutter_architecture/app/data/database/database.dart';
import 'package:flutter_architecture/app/config/interceptors.dart';
import 'package:navigation_history_observer/navigation_history_observer.dart';

import '../data/models/token.dart';
import '../routes/routes_controller.dart';

class Orchestrator {
  static final AppDatabase _db = Get.find<AppDatabase>();
  static final LoginService _loginService = Get.find<LoginService>();
  static final NavigationHistoryObserver historyObserver =
      NavigationHistoryObserver();

  static final routes = [
    '/register',
    '/register/step2',
    '/register/step3',
    '/splash',
    '/login',
    '/validate-login',
  ];

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
          print('************************');
          print(e);
          print('************************');
          final RouteController _route = Get.find();
          await _route.logout();
        }
        wait = false;
      }
    });
  }

  static void _updateRoute() async {
    final history = (await _db.getHistoryRoute()) ?? {'list': []};
    var list = history['list'];
    if (list.length > 5) list = list.sublist(list.length - 5, list.length);

    await Future.delayed(Duration(seconds: 2), () {
      Get.offAllNamed('/');
      if (list.length == 0) {
        Get.offAllNamed('/');
        list = ['/'];
      }
      if (list[0] != '/') list = ['/', ...list];
      list.forEach((route) => Get.toNamed(route));
    });
    await _db.setHistoryRoute({'list': list});

    print(list);

    historyObserver.historyChangeStream.listen((change) {
      final route = Get.currentRoute;
      _db.getHistoryRoute().then((value) {
        final history = value ?? {'list': []};
        var list = history['list'];

        if (Get.previousRoute == route) {
          print(list.sublist(0, list.length - 1));
          _db.setHistoryRoute({'list': list.sublist(0, list.length - 1)});
        } else {
          if (!routes.any((x) => Get.currentRoute == x))
            _db.setHistoryRoute({
              'list': [...list, route]
            });
        }
      });
    });
  }

  static Future<void> init() async {
    _updateRoute();
    _clearTemporary();
    _cleanRecents();
    _resetToken();
  }
}
