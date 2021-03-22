import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:group/views/pages/splash/splash-controller.dart';

class SplashPage extends StatelessWidget {
  final controller = Get.put(SplashController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FractionallySizedBox(
          widthFactor: 0.5,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                margin: EdgeInsets.only(bottom: 15),
                child: Image.asset(
                  'assets/images/logo.png',
                ),
              ),
              CircularProgressIndicator(),
            ],
          ),
        ),
      ),
    );
  }
}
