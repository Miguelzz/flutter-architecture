import 'package:flutter/material.dart';
import 'package:flutter_architecture/app/modules/common/components/button.dart';
import 'package:flutter_architecture/app/modules/common/components/box.dart';
import 'package:flutter_architecture/app/modules/common/components/fullscreen.dart';
import 'package:get/get.dart';
import 'package:flutter_architecture/app/modules/login/login_controller.dart';
import 'package:flutter_architecture/app/routes/routes_controller.dart';

class LoginPage extends StatelessWidget {
  final controller = Get.put(LoginController());
  final RouteController route = Get.find();
  final phone = TextEditingController()..text = '3016992677';
  final bool enabled = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: FullScreen(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Box(
              height: size.height * 0.3,
              child: Center(child: Text('txt_login'.tr)),
            ),
            Box(
              maxWidth: 250,
              child: Column(
                children: [
                  TextField(
                    controller: phone,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Celular',
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ButtonLoading(
                  onPressed: () async {
                    await controller?.login(prefix: '+57', phone: phone.text);
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
