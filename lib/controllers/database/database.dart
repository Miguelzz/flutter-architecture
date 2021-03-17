import 'dart:async';
import 'package:sembast/sembast.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast_io.dart';

class AppDatabase {
  AppDatabase._internal();
  static AppDatabase _singleton = AppDatabase._internal();
  static AppDatabase get instance => _singleton;
  final StoreRef _store = StoreRef.main();

  Completer<Database> _db;
  Future<Database> get database async {
    if (_db == null) {
      _db = Completer();
      this._openDatabase();
    }
    return _db.future;
  }

  Future<dynamic> getDB(String key) async {
    return await _store.record(key).get(await database);
  }

  Future<dynamic> setDB(String key, Map<String, dynamic> data) async {
    return await _store.record(key).put(await database, data);
  }

  Future<void> _openDatabase() async {
    final String dir = (await getApplicationDocumentsDirectory()).path;
    final String dbPath = join(dir, 'app.db');
    final database = await databaseFactoryIo.openDatabase(dbPath);
    _db.complete(database);
  }

  Future<void> close() async {
    await (await _db.future).close();
  }
}
