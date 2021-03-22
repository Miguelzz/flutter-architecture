import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:group/views/pages/main/setting/setting_controller.dart';
import 'package:group/views/routes/routes_controller.dart';

class SettingPage extends StatelessWidget {
  final RouteController route = Get.find();
  final SettingController setting = Get.find();

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
                child: Text('txt_setting'.tr),
              ),
            ),
            Column(
              children: [
                Text('txt_theme'.tr),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        await setting.theme.dark();
                      },
                      child: Text('txt_dart'.tr),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        await setting.theme.light();
                      },
                      child: Text('txt_light'.tr),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        await setting.theme.custom();
                      },
                      child: Text('txt_custom'.tr),
                    ),
                  ],
                ),
              ],
            ),
            Column(
              children: [
                Text('txt_lenguage'.tr),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        await setting.updateLocale(Locale('es'));
                      },
                      child: Text('txt_lenguage_es'.tr),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        await setting.updateLocale(Locale('en'));
                      },
                      child: Text('txt_lenguage_en'.tr),
                    ),
                  ],
                ),
              ],
            ),
            ElevatedButton(
              onPressed: () async {
                route.nexBack();
              },
              child: Text('txt_back'.tr),
            )
          ],
        ),
      ),
    );
  }
}
