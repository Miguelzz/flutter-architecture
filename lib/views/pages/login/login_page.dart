import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:group/views/pages/login/login-controller.dart';
import 'package:group/views/routes/routes_controller.dart';

class LoginPage extends StatelessWidget {
  final login = Get.put(LoginController());
  final RouteController route = Get.find();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            height: size.height * 0.3,
            child: Center(
              child: Text('txt_login'.tr),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () async {
                  login?.getUser();
                },
                child: Text('GET USER'),
              ),
              ElevatedButton(
                onPressed: () async {
                  await route.login('', '');
                },
                child: Text('txt_home'.tr),
              ),
              ElevatedButton(
                onPressed: () async {
                  await route.nexRegister();
                },
                child: Text('txt_register'.tr),
              )
            ],
          )
        ],
      ),
    );
  }
}
