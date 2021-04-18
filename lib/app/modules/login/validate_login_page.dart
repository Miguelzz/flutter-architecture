import 'package:flutter_architecture/app/modules/common/components/input.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_architecture/app/modules/common/components/button.dart';
import 'package:flutter_architecture/app/modules/common/components/fullscreen.dart';
import 'package:flutter_architecture/app/modules/login/login_controller.dart';
import 'package:flutter_architecture/app/routes/routes_controller.dart';

class ValidateLoginPage extends StatelessWidget {
  final controller = Get.put(LoginController());
  final RouteController route = Get.find();
  final code = TextEditingController()..text = '';

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: FullScreen(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              height: size.height * 0.3,
              child: Center(
                child: Text('Autenticate'),
              ),
            ),
            Container(
              width: size.width * 0.7,
              child: Column(
                children: [
                  Input(
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    controller: code,
                    labelText: 'Codigo',
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ButtonLoading(
                  onPressed: () async {
                    await controller?.validateLogin(code: code.text);
                  },
                  child: Text('txt_continue'.tr),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
