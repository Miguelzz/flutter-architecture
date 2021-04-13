import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_architecture/app/modules/main/profile/profile_controller.dart';
import 'package:flutter_architecture/app/routes/routes_controller.dart';

class ProfilePage extends StatelessWidget {
  final controller = Get.put(ProfileController());
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
              width: double.infinity,
              child: GetBuilder<ProfileController>(
                builder: (_) => Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('txt_profile'.tr),
                    Text('${controller?.user?.toJson()}'),
                  ],
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                controller?.getUser();
              },
              child: Text('GET USER'),
            ),
            ElevatedButton(
              onPressed: () async {
                routeController.nexBack();
              },
              child: Text('txt_back'.tr),
            )
          ],
        ),
      ),
    );
  }
}
