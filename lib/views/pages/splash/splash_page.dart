import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:group/views/pages/splash/splash_controller.dart';

class SplashPage extends StatelessWidget {
  final controller = Get.put(SplashController());

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: size.height * 0.9,
              child: FractionallySizedBox(
                widthFactor: 0.5,
                child: Image.asset(
                  'assets/images/logo.png',
                ),
              ),
            ),
            Container(
              height: size.height * 0.1,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
