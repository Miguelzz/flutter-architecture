import 'package:flutter/material.dart';
import 'package:flutter_architecture/app/config/theme/theme.dart';
import 'package:flutter_architecture/app/modules/global_widgets/fullscreen.dart';
import 'package:get/get.dart';
import 'package:flutter_architecture/app/modules/main/setting/setting_controller.dart';
import 'package:flutter_architecture/app/routes/routes_controller.dart';

class SettingPage extends StatelessWidget {
  final RouteController _route = Get.find();
  final SettingController setting = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('txt_1f5bb020'.tr)),
      body: GetBuilder<SettingController>(builder: (_) {
        return FullScreen(
          child: Column(
            children: [
              ListTile(
                title: Text(_.user.names ?? ''),
                subtitle: Text(_.user.surnames ?? ''),
                leading: CircleAvatar(
                  backgroundImage: AssetImage('assets/images/camera.png'),
                ),
                onTap: _route.nexProfile,
              ),
              ListTile(
                title: Text('txt_2c2f3bd7'.tr),
                subtitle: Text(_.theme ? 'txt_6687a8f0'.tr : 'txt_312d2a25'.tr),
                leading: Container(
                  height: double.infinity,
                  child: Icon(Icons.brightness_medium),
                ),
                trailing: Switch(
                  value: _.theme,
                  onChanged: _.updateTheme,
                  activeTrackColor: Colors.grey[300],
                  activeColor: PRIMARY_COLOR,
                ),
              ),
              ListTile(
                title: Text('txt_77f525fe'.tr),
                subtitle: Text('txt_7f182d53'.tr),
                leading: Container(
                  height: double.infinity,
                  child: Icon(Icons.language),
                ),
                trailing: InkWell(
                    child: PopupMenuButton(
                  child: Padding(
                    padding: EdgeInsets.only(right: 10),
                    child: Icon(Icons.more_vert),
                  ),
                  onSelected: setting.updateLocale,
                  itemBuilder: (context) {
                    return [
                      PopupMenuItem(
                        value: 'es',
                        child: Text('txt_16043365'.tr),
                      ),
                      PopupMenuItem(
                        value: 'en',
                        child: Text('txt_761fa136'.tr),
                      ),
                    ];
                  },
                )),
              ),
              ListTile(
                title: Text('txt_26b78d0b'.tr),
                subtitle: Text('txt_d4e2cd3f'.tr),
                leading: Container(
                  height: double.infinity,
                  child: Icon(Icons.delete),
                ),
                onTap: _route.logout,
              ),
            ],
          ),
        );
      }),
    );
  }
}
