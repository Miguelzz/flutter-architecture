import 'package:flutter/material.dart';
import 'package:flutter_architecture/app/routes/routes_controller.dart';
import 'package:get/get.dart';

import '../home_controller.dart';

class MenuTap extends StatelessWidget {
  final RouteController _route = Get.find();

  Widget returnMenu(int index) {
    void onSelected(Object? value) {
      switch (value) {
        case 'setting':
          _route.nexSetting();
          break;
        case 'profile':
          _route.nexProfile();
          break;
        case 'login':
          _route.logout();
          break;
      }
    }

    final options = [
      // ONE
      PopupMenuButton(
        child: Padding(
          padding: EdgeInsets.only(right: 10),
          child: Icon(Icons.more_vert),
        ),
        onSelected: onSelected,
        itemBuilder: (context) {
          return [
            PopupMenuItem(
              value: 'ONE ',
              child: Text('ONE'),
            ),
            PopupMenuItem(
              value: 'setting',
              child: Text('txt_1f5bb020'.tr),
            ),
          ];
        },
      ),
      // TWO
      PopupMenuButton(
        child: Padding(
          padding: EdgeInsets.only(right: 10),
          child: Icon(Icons.more_vert),
        ),
        onSelected: onSelected,
        itemBuilder: (context) {
          return [
            PopupMenuItem(
              value: 'HOME',
              child: Text('HOME'),
            ),
            PopupMenuItem(
              value: 'setting',
              child: Text('txt_1f5bb020'.tr),
            ),
          ];
        },
      ),
      // THREE
      PopupMenuButton(
        child: Padding(
          padding: EdgeInsets.only(right: 10),
          child: Icon(Icons.more_vert),
        ),
        onSelected: onSelected,
        itemBuilder: (context) {
          return [
            PopupMenuItem(
              value: 'THREE ',
              child: Text('THREE'),
            ),
            PopupMenuItem(
              value: 'setting',
              child: Text('txt_1f5bb020'.tr),
            ),
          ];
        },
      )
    ];

    return options[index];
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      id: 'menu_tap',
      builder: (_) => returnMenu(_.indexTab),
    );
  }
}
