import 'package:flutter/material.dart';
import 'package:flutter_architecture/app/config/theme/theme.dart';
import 'package:flutter_architecture/app/modules/global_widgets/button.dart';
import 'package:flutter_architecture/app/modules/global_widgets/fonts.dart';
import 'package:flutter_architecture/app/modules/global_widgets/fullscreen.dart';
import 'package:flutter_architecture/app/modules/global_widgets/input.dart';
import 'package:flutter_architecture/app/modules/global_widgets/image_upload.dart';
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
                  H5(
                    'Información de Perfil',
                    textAlign: TextAlign.center,
                    color: PRIMARY_COLOR,
                  ),
                  SizedBox(height: 20),
                  P('Por favor, ingresa tu nombre y una foto de perfil.',
                      textAlign: TextAlign.center),
                  Center(
                      child: UploadImagePreview(
                    title: 'Foto de Perfil',
                    changueImage: (image) {},
                  )),
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
                    labelText: 'Cual es tu Fecha de nacimiento?',
                    width: size.width * 0.8,
                    debounce: 2000,
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
                  ButtonLoadingFullScreen(
                    onPressed: _.home,
                    after: route.offAllHome,
                    title: 'Espera un momento!',
                    child: Text('txt_f590ead4'.tr),
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
