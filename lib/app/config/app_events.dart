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

  static Future<void> initToken() async {
    Token internalToken = (await _db.getToken()) ?? Token();
    await changueToken(internalToken);
    int max = internalToken.expirationSeconds;
    bool resetAttempt = false;

    Future<void> _intent() async {
      while (true) {
        await Future.delayed(Duration(seconds: 1));
        final connection = (await _connectivity.checkConnectivity()) !=
            ConnectivityResult.none;
        try {
          max--;
          internalToken.expiresAt = Token.expirationDate(max);
          await changueToken(internalToken);
          if (connection) {
            _db.getPreviousCode().then((previousCode) async {
              if (max < 15 && previousCode != null) {
                print('TOKEN_RESET');
                if (!resetAttempt) {
                  resetAttempt = true;
                  internalToken = await _loginService.resetToken();
                  max = internalToken.expirationSeconds;
                  await changueToken(internalToken);
                  resetAttempt = false;
                }
              }
            });
          }
        } catch (e) {
          max = 0;
          resetAttempt = false;
          await route.logout();
        }
      }
    }

    _intent();
  }

  static Future<void> initUser() async {
    final internalUser = (await _db.getUser()) ?? User();
    await changueUser(internalUser);
  }

  static Future<void> init() async {
    initUser();
    initToken();
  }

  static Future<T> dialogLoading<T>(
      String title, Future<T> Function() callback) async {
    final _stop = BehaviorSubject<bool>();
    Get.defaultDialog(
        title: title,
        content: CircularProgressIndicator(backgroundColor: PRIMARY_COLOR),
        onWillPop: () async => await _stop.first);
    final result = await callback();
    Get.back();
    _stop.add(true);
    _stop.close();
    return result;
  }

  close() {
    _controllerUser.close();
    _controllerToken.close();
  }
}
