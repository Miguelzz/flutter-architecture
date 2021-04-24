import 'package:flutter/material.dart';
import 'package:flutter_architecture/app/config/theme/theme.dart';
import 'package:flutter_architecture/app/modules/common/components/button.dart';
import 'package:flutter_architecture/app/modules/common/components/fonts.dart';
import 'package:flutter_architecture/app/modules/common/components/fullscreen.dart';
import 'package:flutter_architecture/app/modules/common/components/input.dart';
import 'package:flutter_architecture/app/modules/common/components/image_upload.dart';
import 'package:flutter_architecture/app/modules/main/profile/profile_controller.dart';
import 'package:flutter_architecture/app/routes/routes_controller.dart';
import 'package:get/get.dart';

class UserInfoPage extends StatelessWidget {
  final RouteController route = Get.find();

  TextSelection endText(int? length) =>
      TextSelection.fromPosition(TextPosition(offset: length ?? 0));

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: GetBuilder<ProfileController>(builder: (_) {
        return FullScreen(
          safeArea: true,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  H4(
                    'Información de Perfil',
                    textAlign: TextAlign.center,
                    color: PRIMARY_COLOR,
                  ),
                  SizedBox(height: 20),
                  P('Por favor, ingresa tu nombre y una foto de perfil. ${_.user.names}',
                      textAlign: TextAlign.center),
                  Center(child: UploadImage()),
                  Input(
                    width: size.width * 0.8,
                    controller: TextEditingController(text: _.user.names)
                      ..selection = endText(_.user.names?.length),
                    onChanged: (value) {
                      _.user.names = value;
                      _.update();
                    },
                    labelText: 'Cual es nombre?',
                    margin: EdgeInsets.only(bottom: 5),
                  ),
                  Input(
                    width: size.width * 0.8,
                    controller: TextEditingController(text: _.user.surnames)
                      ..selection = endText(_.user.surnames?.length),
                    onChanged: (value) {
                      _.user.surnames = value;
                      _.update();
                    },
                    labelText: 'Cual es tu Apellido?',
                    margin: EdgeInsets.only(bottom: 5),
                  ),
                  InputDate(
                    width: size.width * 0.8,
                    initialDateTime:
                        _.user.birthday ?? DateTime(DateTime.now().year - 18),
                    onDateTimeChanged: (newDateTime) async {
                      _.user.birthday = newDateTime;
                      _.update();
                    },
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ButtonLoading(
                    onPressed: _.home,
                    child: Text('txt_continue'.tr),
                  )
                ],
              ),
            ],
          ),
        );
      }),
    );
  }
}