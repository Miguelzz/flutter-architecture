import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:group/views/routes/routes-controller.dart';
import 'package:group/views/pages/home/home-controller.dart';

class Page3Page extends StatelessWidget {
  final HomeController homeController = Get.find();
  final RouteController routeController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Spacer(),
          Text('PAGE 3'),
          ElevatedButton(
            onPressed: () async {
              routeController.nexPageStep2();
            },
            child: Text('IR A PAGE 2'),
          ),
          ElevatedButton(
            onPressed: () async {
              routeController.nexBack();
            },
            child: Text('ATRAS'),
          )
        ],
      )),
    );
  }
}
