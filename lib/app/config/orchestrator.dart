import 'dart:async';
import 'package:get/get.dart';
import 'package:flutter_architecture/app/data/database/database.dart';
import 'package:flutter_architecture/app/config/interceptors.dart';

class Orchestrator {
  static final AppDatabase _db = Get.find<AppDatabase>();

  static final routes = [
    '/terms',
    '/splash',
    '/login',
    '/validate-code',
    '/terms',
    '/read-terms',
    '/validate-number',
  ];

  static void _cleanRecent() {
    Timer.periodic(Duration(seconds: 5), (timer) {
      ServiceTemporary.recentPost = ServiceTemporary.recentPost
          .where((x) => DateTime.now().difference(x.date).inSeconds <= 3)
          .toList();
      ServiceTemporary.recentPut = ServiceTemporary.recentPut
          .where((x) => DateTime.now().difference(x.date).inSeconds <= 3)
          .toList();
      ServiceTemporary.recentGet = ServiceTemporary.recentGet
          .where((x) => DateTime.now().difference(x.date).inSeconds <= 3)
          .toList();
    });
  }

  static void _clearTemporary() {
    Timer.periodic(Duration(days: 1), (timer) async {
      final filter = (await _db.getTemporary())
          .where((x) => DateTime.now().difference(x.date).inDays <= 2)
          .toList();
      await _db.resetTemporary(filter);
    });
  }

  static Future<void> init() async {
    _clearTemporary();
    _cleanRecent();
  }
}
