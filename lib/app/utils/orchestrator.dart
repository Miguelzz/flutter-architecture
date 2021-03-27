import 'dart:async';

import 'package:get/get.dart';
import 'package:group/app/data/database/database.dart';

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
  static void _clearCache() {
    Timer.periodic(new Duration(days: 1), (timer) async {
      final list = await _db.getDB('time-in-cache');

      final filter = TimeInCache.fromJsonArray(list)
          .where((x) => DateTime.now().difference(x.date).inDays <= 2)
          .map((x) => x.key)
          .toList();
      print(filter);

      //await AppDatabase.instance.setDB('time-in-cache', list);
    });
  }

  static init() {
    final _date = DateTime.now();
    final list = [
      TimeInCache('x/0', _date),
      TimeInCache(
          'x/5',
          DateTime(_date.year, _date.month, _date.day, _date.hour, _date.minute,
              _date.second - 5)),
      TimeInCache(
          'x/10',
          DateTime(_date.year, _date.month, _date.day, _date.hour, _date.minute,
              _date.second - 10)),
      TimeInCache(
          'x/15',
          DateTime(_date.year, _date.month, _date.day, _date.hour, _date.minute,
              _date.second - 15)),
      TimeInCache(
          'x/20',
          DateTime(_date.year, _date.month, _date.day, _date.hour, _date.minute,
              _date.second - 20)),
      TimeInCache(
          'x/25',
          DateTime(_date.year, _date.month, _date.day, _date.hour, _date.minute,
              _date.second - 25)),
    ];

    _db
        .setDB('time-in-cache', TimeInCache.toJsonArray(list))
        .then((value) => _clearCache());
  }
}
