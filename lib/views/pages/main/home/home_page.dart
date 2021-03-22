import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:group/views/pages/main/main_controller.dart';
import 'package:group/views/pages/main/home/home_controller.dart';
import 'package:group/views/routes/routes_controller.dart';

class HomePage extends StatelessWidget {
  final controller = Get.put(HomeController());
  final MainController mainController = Get.find();
  final RouteController routeController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Spacer(),
          GetBuilder<HomeController>(
              builder: (_) => Text('HOME ${controller?.user?.toJson()}')),
          ElevatedButton(
            onPressed: () async {
              controller?.getUser();
            },
            child: GetBuilder<HomeController>(
              builder: (_) => Text('GET USER ${controller?.page}'),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () async {
                  routeController.nexSetting();
                },
                child: Text('SETTINGS'),
              ),
              ElevatedButton(
                onPressed: () async {
                  routeController.nexProfile();
                },
                child: Text('PROFILE'),
              ),
              ElevatedButton(
                onPressed: () async {
                  routeController.nexNone();
                },
                child: Text('NONE'),
              ),
            ],
          ),
          ElevatedButton(
            onPressed: () async {
              routeController.logout();
            },
            child: Text('LOGIN'),
          )
        ],
      )),
    );
  }
}
