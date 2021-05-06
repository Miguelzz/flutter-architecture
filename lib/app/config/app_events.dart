import 'package:flutter/material.dart';
import 'package:flutter_architecture/app/config/theme/theme.dart';
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
  static final Connectivity _connectivity = Connectivity();
  static final AppDatabase _db = Get.find<AppDatabase>();
  static final LoginService _loginService = Get.find<LoginService>();
  static final RouteController route = Get.find();

  // TOKEN
  static Token get token => _controllerToken.value ?? Token();
  static String get stringToken => _controllerToken.value?.token ?? '';
  static final _controllerToken = BehaviorSubject<Token>();
  static Stream<Token> token$ = _controllerToken.stream.asBroadcastStream();
  static Future<void> changueToken(Token newToken) async {
    await _db.setToken(newToken);
    _controllerToken.sink.add(newToken);
  }

  // USER
  static get user => _controllerUser.value ?? User();
  static final _controllerUser = BehaviorSubject<User>();
  static Stream<User> user$ = _controllerUser.stream.asBroadcastStream();
  static Future<void> changueUser(User user) async {
    await _db.setUser(user);
    _controllerUser.sink.add(user);
  }

  static Future<void> _initToken() async {
    Token internalToken = (await _db.getToken()) ?? Token();
    await changueToken(internalToken);
    int max = internalToken.expirationSeconds;
    bool resetAttempt = false;

    Timer.periodic(Duration(seconds: 1), (t) async {
      max--;
      internalToken.expiresAt = Token.expirationDate(max);
      _controllerToken.sink.add(internalToken);
      if (max % 10 == 0) changueToken(internalToken);

      if (max < 15) {
        _db.getPreviousCode().then((previousCode) async {
          //print('TOKEN_RESET $max');
          final connection = (await _connectivity.checkConnectivity()) !=
              ConnectivityResult.none;
          if (!resetAttempt && previousCode != null && connection) {
            try {
              resetAttempt = true;
              internalToken = await _loginService.resetToken();
              max = internalToken.expirationSeconds;
              await changueToken(internalToken);
              resetAttempt = false;
            } catch (e) {
              max = 0;
              resetAttempt = false;
              await route.logout();
            }
          }
        });
      }
    });
  }

  static Future<void> _initUser() async {
    final internalUser = (await _db.getUser()) ?? User();
    await changueUser(internalUser);
  }

  static Future<void> init() async {
    _initUser();
    _initToken();
  }

  close() {
    _controllerUser.close();
    _controllerToken.close();
  }
}
