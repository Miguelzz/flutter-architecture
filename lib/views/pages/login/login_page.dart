import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:group/views/pages/login/login-controller.dart';
import 'package:group/views/pages/main-controller.dart';
import 'package:group/views/routes/routes-controller.dart';

class LoginPage extends StatelessWidget {
  final controller = Get.put(LoginController());

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
          Text('LOGIN'),
          Text('title'.trArgs(['...'])),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () async {
                  await mainController.theme.dark();
                },
                child: Text('DART'),
              ),
              ElevatedButton(
                onPressed: () async {
                  await mainController.theme.light();
                },
                child: Text('LINGHT'),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () async {
                  await mainController.updateLocale(Locale('es'));
                },
                child: Text('ESPAÑOL'),
              ),
              ElevatedButton(
                onPressed: () async {
                  await mainController.updateLocale(Locale('pt'));
                },
                child: Text('PORTUGAL'),
              ),
              ElevatedButton(
                onPressed: () async {
                  await mainController.updateLocale(Locale('en'));
                },
                child: Text('INGLES'),
              ),
            ],
          ),
          ElevatedButton(
            onPressed: () async {
              await controller!.login('', '');
            },
            child: Text('HOME'),
          ),
          ElevatedButton(
            onPressed: () async {
              await routeController.nexRegister();
            },
            child: Text('REGISTER'),
          )
        ],
      )),
    );
  }
}
