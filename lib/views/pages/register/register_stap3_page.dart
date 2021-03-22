import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:group/views/routes/routes_controller.dart';

class RegisterStep3Page extends StatelessWidget {
  final RouteController routeController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Spacer(),
          Text('REGISTER 3'),
          ElevatedButton(
            onPressed: () async {
              await routeController.offAllHome();
            },
            child: Text('FINALIZAR REGISTRO'),
          )
        ],
      )),
    );
  }
}
