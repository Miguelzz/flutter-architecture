import 'package:flutter/material.dart';
import 'package:flutter_architecture/app/config/app_events.dart';
import 'package:flutter_architecture/app/data/models/demo.dart';
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
  int indexTab = 1;

  List<Demo> tapOneContent = [];
  List<Demo> tapHomeContent = [];
  List<Demo> tapThreeContent = [];

  int _pageOneSearch = 0, _pageHomeSearch = 0, _pageThreeSearch = 0;

  String _queryOne = '', _queryHome = '', _queryThree = '';

  List<Demo> tapOneSearch = [];
  List<Demo> tapHomeSearch = [];
  List<Demo> tapThreeSearch = [];

  String get query {
    if (indexTab == 0) return _queryOne;
    if (indexTab == 1) return _queryHome;
    if (indexTab == 2) return _queryThree;
    return '';
  }

  set query(String value) {
    if (indexTab == 0) _queryOne = value;
    if (indexTab == 1) _queryHome = value;
    if (indexTab == 2) _queryThree = value;
  }

  int get page {
    if (indexTab == 0) return _pageOneSearch;
    if (indexTab == 1) return _pageHomeSearch;
    if (indexTab == 2)
      return _pageThreeSearch;
    else
      return 0;
  }

  set page(int value) {
    if (indexTab == 0) _pageOneSearch = value;
    if (indexTab == 1) _pageHomeSearch = value;
    if (indexTab == 2) _pageThreeSearch = value;
  }

  Future<void> searchTab(String value) async {
    page = 1;
    query = value.toLowerCase();
    switch (indexTab) {
      case 0:
        final result = await _appService.paginateSearch(query, page, 30);
        tapOneSearch = result.docs ?? [];
        break;
      case 1:
        final result = await _appService.paginateSearch(query, page, 30);
        tapHomeSearch = result.docs ?? [];
        break;
      case 2:
        final result = await _appService.paginateSearch(query, page, 30);
        page = result.page ?? 0;
        tapThreeSearch = result.docs ?? [];
        break;
    }
    update(['search_tap']);
  }

  List<T> limitMemory<T>(List<T> list, List<T> listAdd, int max) {
    print('before ${list.length} after ${listAdd.length}');
    List<T> slave = [...list, ...listAdd];
    if (slave.length > 15 * max) slave.sublist(slave.length - (15 * max));
    return slave;
  }

  Future<void> searchNextTab() async {
    page++;
    switch (indexTab) {
      case 0:
        final result = await _appService.paginateSearch(query, page, 15);
        if (result.docs?.length == 0) page--;
        tapOneSearch = limitMemory(tapOneSearch, result.docs ?? [], 3);
        break;
      case 1:
        final result = await _appService.paginateSearch(query, page, 15);
        if (result.docs?.length == 0) page--;
        tapHomeSearch = limitMemory(tapHomeSearch, result.docs ?? [], 3);
        break;
      case 2:
        final result = await _appService.paginateSearch(query, page, 15);
        if (result.docs?.length == 0) page--;
        tapThreeSearch = limitMemory(tapThreeSearch, result.docs ?? [], 3);
        break;
    }
    update(['search_tap']);
  }

  changueTab(int value) {
    indexTab = value;
    update(['menu_tap', 'search_tap', 'float_tap']);
  }

  nexPage(int value) {
    page = value;
    //update(['menu_tap', 'search_tap', 'float_tap']);
  }

  Future<Demo> createDemo(List<String> filesPaths, Demo demo) async =>
      await _appService.createDemo(filesPaths, demo);

  addTapHomeContent(Demo demo) {
    tapHomeContent.add(demo);
    update(['tap-home']);
  }

  @override
  void onInit() async {
    super.onInit();

    final result = await _appService.paginateSearch(query, page, 30);
    tapHomeContent = result.docs ?? [];
    update(['search_tap', 'tap-home']);

    // EventsApp.token$.listen((token) {
    //   this.token = token;
    //   final date = token.mapType<DateTime>(token.expiresAt) ?? DateTime.now();
    //   final duration = date.difference(DateTime.now());
    //   final days = duration.inDays;
    //   final hours = duration.inHours - (duration.inDays * 24);
    //   final minutes = duration.inMinutes - (duration.inHours * 60);
    //   final seconds = duration.inSeconds - (duration.inMinutes * 60);

    //   countdown =
    //       '$days dias | $hours horas | $minutes minutos | $seconds segundos';

    //   update();
    // });

    // EventsApp.user$.listen((token) {
    //   this.user = user;
    //   update();
    // });

    print('HOME');
  }
}
