import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:group/views/routes/routes_controller.dart';

class ProfilePage extends StatelessWidget {
  final RouteController routeController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Spacer(),
          Text('PROFILE'),
          ElevatedButton(
            onPressed: () async {
              routeController.nexSetting();
            },
            child: Text('SETTINGS'),
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
