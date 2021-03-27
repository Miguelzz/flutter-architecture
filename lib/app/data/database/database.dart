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
  static late Database db;

  static init() async {
    final String dir = (await getApplicationDocumentsDirectory()).path;
    final String dbPath = join(dir, 'my-app.db');
    final dbOpen = await databaseFactoryIo.openDatabase(dbPath);
    _completer = Completer();
    _completer.complete(dbOpen);
    db = await _completer.future;
  }

  Future<String?> getTheme() async => await getDB('theme');
  Future<void> setTheme(String theme) async =>
      await _store.record('theme').put(db, theme);

  Future<String?> getToken() async => await getDB('token');
  Future<void> setToken(String token) async =>
      await _store.record('token').put(db, token);

  Future<String?> getRoute() async => await getDB('route');
  Future<void> setRoute(String name) async {
    var route = '/splash';
    try {
      route = routes.firstWhere((e) => e.name == name).name;
    } catch (e) {}
    await _store.record('route').put(db, route);
  }

  Future<void> setLocale(Locale locale) async {
    await _store.record('locale').put(db, {
      'languageCode': locale.languageCode,
      'countryCode': locale.countryCode,
    });
  }

  Future<Locale?> getLocale() async {
    final locale = await this.getDB('locale');
    if (locale == null) return null;
    return Locale(locale['languageCode'], locale['countryCode']);
  }

  Future<dynamic> getDB(String key) async => await _store.record(key).get(db);

  Future<dynamic> setDB(String key, dynamic data) async {
    if (key == 'time-in-cache' ||
        key == 'route' ||
        key == 'locale' ||
        key == 'theme' ||
        key == 'token') {
      print('palabra $key no puede usarse como clave de almacenamiento');
    } else {
      await _addCache(key);
      return await _store.record(key).put(db, data);
    }
  }

  Future<void> _addCache(String key) async {
    final _list =
        TimeInCache.fromJsonArray((await _store.record(key).get(db)) ?? []);

    _list.add(TimeInCache(key, DateTime.now()));

    await _store
        .record('time-in-cache')
        .put(db, TimeInCache.toJsonArray(_list));
  }

  Future<void> close() async {
    await db.close();
  }
}
