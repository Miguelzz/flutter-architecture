import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:group/views/pages/register/register-controller.dart';
import 'package:group/views/routes/routes-controller.dart';

class RegisterPage extends StatelessWidget {
  final controller = Get.put(RegisterController());
  final RouteController routeController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Spacer(),
          Text('REGISTER 1'),
          ElevatedButton(
            onPressed: () async {
              await routeController.nexRegisterStep2();
            },
            child: Text('CONTINUAR REGISTRO'),
          )
        ],
      )),
    );
  }
}
