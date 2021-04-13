import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_architecture/app/modules/login/login_controller.dart';
import 'package:flutter_architecture/app/routes/routes_controller.dart';

class LoginPage extends StatelessWidget {
  final controller = Get.put(LoginController());
  final RouteController route = Get.find();
  final phone = TextEditingController()..text = '3016992677';

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
          Container(
            width: size.width * 0.7,
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
              ElevatedButton(
                onPressed: () async {
                  FocusScope.of(context).requestFocus(FocusNode());
                  await controller?.login(prefix: '+57', phone: phone.text);
                },
                child: Text('txt_continue'.tr),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
