import 'dart:async';
import 'package:get/get.dart';
import 'package:group/app/data/database/database.dart';
import 'package:group/app/data/services/interceptors.dart';

class TimeInCache {
  final String key;
  final DateTime date;
  TimeInCache(this.key, this.date);

  Map<String, dynamic> toJson() => {'key': key, 'date': date.toString()};

  static TimeInCache fromJson(dynamic json) =>
      TimeInCache(json['key'], DateTime.parse(json['date']));

  static List<TimeInCache> fromJsonArray(List<dynamic> json) {
    return json.map((x) => TimeInCache.fromJson(x)).toList();
  }

  static List<Map<String, dynamic>> toJsonArray(List<TimeInCache> listJson) =>
      listJson.map((x) => {'key': x.key, 'date': x.date.toString()}).toList();
}

class Orchestrator {
  static final AppDatabase _db = Get.find<AppDatabase>();

  static void _cleanRecents() {
    Timer.periodic(new Duration(seconds: 5), (timer) {
      ServiceCache.recentPost = ServiceCache.recentPost
          .where((x) => DateTime.now().difference(x.date).inSeconds <= 10)
          .toList();
      ServiceCache.recentGet = ServiceCache.recentGet
          .where((x) => DateTime.now().difference(x.date).inSeconds <= 10)
          .toList();
    });
  }

  static void _clearCache() {
    Timer.periodic(new Duration(days: 1), (timer) async {
      final filter = (await _db.getTemporary())
          .where((x) => DateTime.now().difference(x.date).inDays <= 2)
          .toList();
      await _db.resetTemporary(filter);
    });
  }

  static Future<void> init() async {
    _clearCache();
    _cleanRecents();
  }
}
