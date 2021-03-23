import 'dart:async';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/services.dart';

class ConnetivityService {
  final Connectivity _connectivity = Connectivity();

  bool connection = false;
  StreamSubscription<ConnectivityResult>? _connectivitySubscription;

  static final ConnetivityService _singleton = ConnetivityService._internal();
  factory ConnetivityService() => _singleton;
  static ConnetivityService get instance => _singleton;
  ConnetivityService._internal();

  Future<void> init() async {
    await this._initConnectivity();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  Future<void> _initConnectivity() async {
    ConnectivityResult? result;
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      print(e.toString());
    }
    return _updateConnectionStatus(result);
  }

  _updateConnectionStatus(ConnectivityResult? result) async {
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

  bool test() {
    return connection;
  }

  close() {
    _connectivitySubscription!.cancel();
  }
}
