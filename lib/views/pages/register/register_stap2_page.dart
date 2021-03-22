import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:group/controller/routes-controller.dart';

class RegisterStep2Page extends StatelessWidget {
  final RouteController routeController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Spacer(),
          Text('REGISTER 2'),
          ElevatedButton(
            onPressed: () async {
              await routeController.nexRegisterStep3();
            },
            child: Text('CONTINUAR REGISTRO'),
          )
        ],
      )),
    );
  }
}
