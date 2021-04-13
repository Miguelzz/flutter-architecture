import 'dart:async';
import 'package:get/get.dart';
import 'package:flutter_architecture/app/data/database/database.dart';
import 'package:flutter_architecture/app/utils/interceptors.dart';

class Orchestrator {
  static final AppDatabase _db = Get.find<AppDatabase>();

  static void _cleanRecents() {
    Timer.periodic(new Duration(seconds: 5), (timer) {
      ServiceTemporary.recentPost = ServiceTemporary.recentPost
          .where((x) => DateTime.now().difference(x.date).inSeconds <= 10)
          .toList();
      ServiceTemporary.recentGet = ServiceTemporary.recentGet
          .where((x) => DateTime.now().difference(x.date).inSeconds <= 10)
          .toList();
    });
  }

  static void _clearTemporary() {
    Timer.periodic(new Duration(days: 1), (timer) async {
      final filter = (await _db.getTemporary())
          .where((x) => DateTime.now().difference(x.date).inDays <= 2)
          .toList();
      await _db.resetTemporary(filter);
    });
  }

  static Future<void> init() async {
    _clearTemporary();
    _cleanRecents();
  }
}
