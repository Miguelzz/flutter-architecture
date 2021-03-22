import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:group/views/pages/home/home-controller.dart';
import 'package:group/views/pages/main-controller.dart';
import 'package:group/views/routes/routes-controller.dart';

class HomePage extends StatelessWidget {
  final HomeController homeController = Get.find();
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
              builder: (_) => Text('HOME ${homeController.user?.toJson()}')),
          ElevatedButton(
            onPressed: () async {
              homeController.getUser();
            },
            child: Text('GET USER'),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () async {
                  routeController.nexPageStep2();
                },
                child: Text('PAGE 2'),
              ),
              ElevatedButton(
                onPressed: () async {
                  routeController.nexPageStep3();
                },
                child: Text('PAGE 3'),
              ),
            ],
          ),
          ElevatedButton(
            onPressed: () async {
              routeController.nexSplash();
            },
            child: Text('LOGIN'),
          )
        ],
      )),
    );
  }
}
