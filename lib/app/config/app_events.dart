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

  static Future<void> initToken(Token internalToken) async {
    int max = internalToken.expirationSeconds;
    bool resetAttempt = false;

    Timer.periodic(Duration(seconds: 1), (timer) async {
      try {
        if (token.expirationSeconds < 15) {
          if (!resetAttempt) {
            print('resetToken');
            resetAttempt = true;
            final user = EventsApp.user;
            final previousCode = await _db.getPreviousCode();

            if (previousCode != null) {
              internalToken = await _loginService
                  .resetToken(user.prefix!, user.phone!, previousCode)
                  .first;
              max = internalToken.expirationSeconds;
              await changueToken(internalToken);
              resetAttempt = false;
            }
          }
        } else {
          max--;
          internalToken.expiresAt = Token.expirationDate(max);
          await changueToken(token);
        }
      } catch (e) {}
    });
  }

  static Future<void> initUser(User internalUser) async {
    changueUser(internalUser);
  }

  static Future<void> init() async {
    final user = (await _db.getUser()) ?? User();
    final token = (await _db.getToken()) ?? Token();
    await changueToken(token);
    await changueUser(user);
    await initUser(user);
    await initToken(token);
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

  cancel() {
    _connectivitySubscription.cancel();
  }
}
