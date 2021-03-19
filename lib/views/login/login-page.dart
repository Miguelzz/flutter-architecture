import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myArchitecture/controller/main-controller.dart';

class LoginPage extends StatelessWidget {
  final controller = Get.put(MainController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Spacer(),
          Text('LOGIN'),
          ElevatedButton(
            onPressed: () async {
              controller!.route('/');
              controller!.autenticate(true);
            },
            child: Text('IR A HOME'),
          )
        ],
      )),
    );
  }
}
