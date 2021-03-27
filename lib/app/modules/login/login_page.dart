import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:group/app/modules/login/login-controller.dart';
import 'package:group/app/routes/routes_controller.dart';

class LoginPage extends StatelessWidget {
  final login = Get.put(LoginController());
  final RouteController route = Get.find();
  final phone = TextEditingController();

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
                // SizedBox(
                //   height: 20,
                // ),
                // InkWell(
                //   child: Text("Registrate ahora"),
                //   onTap: () async {
                //     await route.nexRegister();
                //   },
                // )
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // ElevatedButton(
              //   onPressed: () async {
              //     login?.getUser();
              //   },
              //   child: Text('GET USER'),
              // ),
              ElevatedButton(
                onPressed: () async {
                  FocusScope.of(context).requestFocus(FocusNode());
                  await route.login(prefix: '+57', phone: phone.text);
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
