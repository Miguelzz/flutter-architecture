import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:group/controller/routes-controller.dart';
import 'package:group/controller/user-controller.dart';
import 'package:group/controller/main-controller.dart';

class HomePage extends StatelessWidget {
  final UserController userController = Get.find();
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
          GetBuilder<UserController>(
              builder: (_) => Text('HOME ${userController.user?.toJson()}')),
          ElevatedButton(
            onPressed: () async {
              userController.getUser();
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
