import 'package:flutter_architecture/app/data/database/database.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter_architecture/app/data/models/token.dart';
import 'package:flutter_architecture/app/data/models/user.dart';
import 'package:flutter_architecture/app/data/services/login/login_service.dart';
import 'package:flutter_architecture/app/routes/routes_controller.dart';
import 'package:get/get.dart';
import 'package:rxdart/rxdart.dart';
import 'dart:async';

class EventsApp {
  static final AppDatabase _db = Get.find<AppDatabase>();
  static final LoginService _loginService = Get.find<LoginService>();
  static late StreamSubscription<ConnectivityResult> _connectivitySubscription;
  static final RouteController route = Get.find();

  static String get stringToken => _controllerToken.value?.token ?? '';
  static Token get token => _controllerToken.value ?? Token();
  static final _controllerToken = BehaviorSubject<Token>();
  static Stream<Token> token$ = _controllerToken.stream.asBroadcastStream();
  static Future<void> changueToken(Token token) async {
    _controllerToken.sink.add(token);
    await _db.setToken(token);
  }

  static User get user => _controllerUser.value ?? User();
  static final _controllerUser = BehaviorSubject<User>();
  static Stream<User> user$ = _controllerUser.stream.asBroadcastStream();
  static Future<void> changueUser(User user) async {
    _controllerUser.sink.add(user);
    await _db.setUser(user);
  }

  static Future<void> initToken() async {
    Token token = (await _db.getToken()) ?? Token();
    changueToken(token);
    int max = token.expirationSeconds;
    bool resetAttempt = false;
    bool logout = false;

    Timer.periodic(Duration(seconds: 1), (timer) async {
      if (max < 15) {
        if (!resetAttempt) {
          resetAttempt = true;
          print('resetToken');
          final user = await _db.getUser();
          final previousCode = await _db.getPreviousCode();

          if (user == null || previousCode == null) {
            if (!logout) {
              await route.logout();
              logout = true;
              print('logout');
            }
            resetAttempt = false;
          } else {
            try {
              token = await _loginService
                  .resetToken(user.prefix!, user.phone!, previousCode)
                  .first;
              max = token.expirationSeconds;
              await _db.setToken(token);
              resetAttempt = false;
            } catch (e) {}
          }
        }
      } else {
        max--;
        token.expiresAt = Token.expirationDate(max);
        changueToken(token);
      }
    });
  }

  static Future<void> initUser() async {
    User user = (await _db.getUser()) ?? User();
    changueUser(user);
  }

  static Future<void> init() async {
    await initToken();
    await initUser();
  }

  close() {
    _controllerUser.close();
    _controllerToken.close();
  }

  cancel() {
    _connectivitySubscription.cancel();
  }
}
