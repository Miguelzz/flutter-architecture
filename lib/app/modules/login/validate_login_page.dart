import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
      body: Column(
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
                TextField(
                  controller: code,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Codigo',
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
                  await controller?.validateLogin(code: code.text);
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
