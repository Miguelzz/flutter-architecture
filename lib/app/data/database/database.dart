import 'dart:async';
import 'package:group/app/routes/routes.dart';
import 'package:group/app/utils/orchestrator.dart';
import 'package:sembast/sembast.dart';
import 'package:flutter/rendering.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast_io.dart';

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
        'token',
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

  Future<String?> getToken() async => await getKey('token');
  Future<void> setToken(String token) async =>
      await _store.record('token').put(_db, token);

  Future<String?> getRoute() async => await getKey('route');
  Future<void> setRoute(String route) async {
    if (!_reservedKeys(route) && _reservedRoutes(route)) {
      await _store.record('route').put(_db, route);
    }
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
      _list.add(TimeInCache(key, DateTime.now()));

      await _store
          .record('time-in-cache')
          .put(_db, TimeInCache.toJsonArray(_list));
      return await _store.record(key).put(_db, data);
    }
  }

  Future<List<TimeInCache>> getTemporary() async => TimeInCache.fromJsonArray(
      (await _store.record('time-in-cache').get(_db)) ?? []);

  Future<void> close() async {
    await _db.close();
  }
}
