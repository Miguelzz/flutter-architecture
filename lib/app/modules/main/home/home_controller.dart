import 'package:flutter/material.dart';
import 'package:flutter_architecture/app/config/app_events.dart';
import 'package:flutter_architecture/app/data/models/token.dart';
import 'package:flutter_architecture/app/data/services/app/app_service.dart';
import 'package:flutter_architecture/app/data/models/user.dart';
import 'package:flutter_architecture/app/routes/routes_controller.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final RouteController _route = Get.find();
  final AppService _appService = Get.find();
  Token token = EventsApp.token;
  User user = EventsApp.user;
  String countdown = '';
  int index = 1;

  List<Widget> get listSearch => searchTabs[index];
  List<List<Widget>> searchTabs = [
    // ONE
    [],
    // TWO
    [],
    // THREE
    [],
  ];

  Future<void> searchTab(String value) async {
    final query = value.toLowerCase();
    switch (index) {
      case 0:
        final result = await _appService.searchOne(query);
        searchTabs[0] = result
            .map((x) => InkWell(
                child: ListTile(
                  title: Text(x.title ?? ''),
                  subtitle: Text('nada'),
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(x.image ?? ''),
                  ),
                  onTap: _route.nexProfile,
                ),
                onTap: () {
                  _route.nexRoute('/profile');
                }))
            .toList();

        break;
      case 1:
        final result = await _appService.searchTwo(query);
        print(result);
        searchTabs[1] = result
            .map((x) => InkWell(
                child: ListTile(
                  title: Text(x.title ?? ''),
                  subtitle: Text('nada'),
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(x.image ?? ''),
                  ),
                  onTap: _route.nexProfile,
                ),
                onTap: () {
                  _route.nexRoute('/profile');
                }))
            .toList();

        break;
      case 2:
        final result = await _appService.searchThree(query);
        searchTabs[2] = result
            .map((x) => InkWell(
                child: ListTile(
                  title: Text(x.title ?? ''),
                  subtitle: Text('nada'),
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(x.image ?? ''),
                  ),
                  onTap: _route.nexProfile,
                ),
                onTap: () {
                  _route.nexRoute('/profile');
                }))
            .toList();
        break;
    }
    update();
  }

  changueTab(int value) {
    index = value;
    update();
  }

  @override
  void onInit() async {
    super.onInit();

    EventsApp.token$.listen((token) {
      this.token = token;
      final date = token.mapType<DateTime>(token.expiresAt) ?? DateTime.now();
      final duration = date.difference(DateTime.now());
      final days = duration.inDays;
      final hours = duration.inHours - (duration.inDays * 24);
      final minutes = duration.inMinutes - (duration.inHours * 60);
      final seconds = duration.inSeconds - (duration.inMinutes * 60);

      countdown =
          '$days dias | $hours horas | $minutes minutos | $seconds segundos';

      update();
    });

    EventsApp.user$.listen((token) {
      this.user = user;
      update();
    });

    print('HOME');
  }
}
