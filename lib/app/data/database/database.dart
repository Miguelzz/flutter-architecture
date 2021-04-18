import 'dart:async';
import 'package:flutter_architecture/app/data/database/data-preloaded.dart';
import 'package:flutter_architecture/app/routes/routes.dart';
import 'package:sembast/sembast.dart';
import 'package:flutter/rendering.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast_io.dart';

import '../models/token.dart';
import '../models/user.dart';

class TemporaryData {
  final String key;
  final DateTime date;
  TemporaryData(this.key, this.date);

  Map<String, dynamic> toJson() => {'key': key, 'date': date.toString()};

  static TemporaryData fromJson(dynamic json) =>
      TemporaryData(json['key'], DateTime.parse(json['date']));

  static List<TemporaryData> fromJsonArray(List<dynamic> json) {
    return json.map((x) => TemporaryData.fromJson(x)).toList();
  }

  static List<Map<String, dynamic>> toJsonArray(List<TemporaryData> listJson) =>
      listJson.map((x) => {'key': x.key, 'date': x.date.toString()}).toList();
}

class AppDatabase {
  final StoreRef _store = StoreRef.main();
  static late Completer<Database> _completer;
  static late Database _db;

  static bool _reservedRoutes(String route) {
    try {
      routes.firstWhere((e) => e.name == route);
      return true;
    } catch (e) {
      print('la route "$route" no puede usarse como clave de routeName');
      return false;
    }
  }

  static bool _reservedKeys(String key) {
    try {
      [
        'time-in-cache',
        'route',
        'locale',
        'theme',
        'previousCode',
        'token',
        'histoy-route-8'
      ].firstWhere((x) => x == key);
      print('la key "$key" no puede usarse como clave de almacenamiento');
      return true;
    } catch (e) {
      return false;
    }
  }

  static init() async {
    final String dir = (await getApplicationDocumentsDirectory()).path;
    final String dbPath = join(dir, 'my-app.db');
    final dbOpen = await databaseFactoryIo.openDatabase(dbPath);
    _completer = Completer();
    _completer.complete(dbOpen);
    _db = await _completer.future;
  }

  Future<String?> getTheme() async => await getKey('theme');
  Future<void> setTheme(String theme) async =>
      await _store.record('theme').put(_db, theme);

  Future<Token?> getToken() async => Token().fromJson(await getKey('token'));
  Future<void> setToken(Token token) async {
    DataPreloaded.token = token;
    return await _store.record('token').put(_db, token.toJson());
  }

  Future<String?> getPreviousCode() async => await getKey('previousCode');
  Future<void> setPreviousCode(String code) async {
    DataPreloaded.previousCode = code;
    return await _store.record('previousCode').put(_db, code);
  }

  Future<User?> getUser() async => User().fromJson(await getKey('user'));
  Future<void> setUser(User user) async {
    DataPreloaded.user = user;
    return await _store.record('user').put(_db, user.toJson());
  }

  Future<String?> getRoute() async => await getKey('route');
  Future<void> setRoute(String route) async {
    if (!_reservedKeys(route) && _reservedRoutes(route)) {
      await _store.record('route').put(_db, route);
    }
  }

  Future<Map<String, dynamic>?> getHistoryRoute() async =>
      await getKey('histoy-route-8');
  Future<void> setHistoryRoute(Map<String, dynamic> routes) async {
    await _store.record('histoy-route-8').put(_db, routes);
  }

  Future<Locale?> getLocale() async {
    final locale = await this.getKey('locale');
    if (locale == null) return null;
    return Locale(locale['languageCode'], locale['countryCode']);
  }

  Future<void> setLocale(Locale locale) async {
    await _store.record('locale').put(_db, {
      'languageCode': locale.languageCode,
      'countryCode': locale.countryCode,
    });
  }

  Future<dynamic> getKey(String key) async => await _store.record(key).get(_db);

  Future<dynamic> setPersist(String key, dynamic data) async {
    if (!_reservedKeys(key)) {
      return await _store.record(key).put(_db, data);
    }
  }

  Future<dynamic> setTemporary(String key, dynamic data) async {
    if (!_reservedKeys(key)) {
      final _list = await getTemporary();
      _list.add(TemporaryData(key, DateTime.now()));

      await _store
          .record('time-in-cache')
          .put(_db, TemporaryData.toJsonArray(_list));
      return await _store.record(key).put(_db, data);
    }
  }

  Future<dynamic> resetTemporary(List<TemporaryData> listJson) async {
    await _store
        .record('time-in-cache')
        .put(_db, TemporaryData.toJsonArray(listJson));
  }

  Future<List<TemporaryData>> getTemporary() async =>
      TemporaryData.fromJsonArray(
          (await _store.record('time-in-cache').get(_db)) ?? []);

  Future<void> close() async {
    await _db.close();
  }
}
