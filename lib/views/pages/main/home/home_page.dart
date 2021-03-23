import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:group/views/pages/main/main_controller.dart';
import 'package:group/views/pages/main/home/home_controller.dart';
import 'package:group/views/routes/routes_controller.dart';

class HomePage extends StatelessWidget {
  final home = Get.put(HomeController());
  final MainController mainController = Get.find();
  final RouteController routeController = Get.find();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: size.height * 0.3,
              child: Center(
                child: Text('txt_home'.tr),
              ),
            ),
            Container(
              width: size.width * 0.7,
              child: GetBuilder<HomeController>(
                builder: (_) => Text('${home?.token}'),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    routeController.nexSetting();
                  },
                  child: Text('txt_setting'.tr),
                ),
                ElevatedButton(
                  onPressed: () async {
                    routeController.nexProfile();
                  },
                  child: Text('txt_profile'.tr),
                ),
              ],
            ),
            ElevatedButton(
              onPressed: () async {
                routeController.logout();
              },
              child: Text('txt_login'.tr),
            )
          ],
        ),
      ),
    );
  }
}
