import 'dart:async';
import 'package:sembast/sembast.dart';
import 'package:flutter/rendering.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast_io.dart';
import 'package:group/views/routes/routes.dart';

class AppDatabase {
  static final AppDatabase _singleton = AppDatabase._internal();
  factory AppDatabase() => _singleton;
  static AppDatabase get instance => _singleton;
  AppDatabase._internal();

  final StoreRef _store = StoreRef.main();

  Completer<Database>? _db;
  Future<Database> get database async {
    if (_db == null) {
      _db = Completer();
      this._openDatabase();
    }
    return _db!.future;
  }

  Future<String?> getTheme() async => await getDB('theme');
  Future<void> setTheme(String theme) async =>
      await _store.record('theme').put(await database, theme);

  Future<String?> getToken() async => await getDB('token');
  Future<void> setToken(String token) async =>
      await _store.record('token').put(await database, token);

  Future<String?> getRoute() async => await getDB('route');
  Future<void> setRoute(String name) async {
    var route = '/splash';
    try {
      route = routes.firstWhere((e) => e.name == name).name;
    } catch (e) {}
    await _store.record('route').put(await database, route);
  }

  Future<void> setLocale(Locale locale) async {
    await _store.record('locale').put(await database, {
      'languageCode': locale.languageCode,
      'countryCode': locale.countryCode,
    });
  }

  Future<Locale?> getLocale() async {
    final locale = await this.getDB('locale');
    if (locale == null) return null;
    return Locale(locale['languageCode'], locale['countryCode']);
  }

  Future<dynamic> getDB(String key) async =>
      await _store.record(key).get(await database);

  Future<dynamic> setDB(String key, dynamic data) async {
    if (key == 'route' || key == 'locale' || key == 'theme' || key == 'token') {
      print('palabra $key no puede usarse como clave de almacenamiento');
    } else {
      return await _store.record(key).put(await database, data);
    }
  }

  Future<void> _openDatabase() async {
    final String dir = (await getApplicationDocumentsDirectory()).path;
    final String dbPath = join(dir, 'app.db');
    final database = await databaseFactoryIo.openDatabase(dbPath);
    _db!.complete(database);
  }

  Future<void> close() async {
    await (await _db!.future).close();
  }
}
