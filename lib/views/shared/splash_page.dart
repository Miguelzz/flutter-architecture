import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myArchitecture/controller/splash-controller.dart';

class SplashPage extends StatelessWidget {
  final controller = Get.put(SplashController());

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        children: [
          Spacer(),
          Center(
            child: FractionallySizedBox(
              widthFactor: 0.6,
              child: Image.asset(
                'assets/images/logo.png',
                width: size.width * 0.60,
                height: size.width * 0.60,
              ),
            ),
          ),
          Spacer(),
          CircularProgressIndicator(),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
