import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_architecture/app/modules/common/components/image_upload.dart';
import 'package:image_picker/image_picker.dart';

import 'package:flutter_architecture/app/modules/common/components/fullscreen.dart';
import 'package:flutter_architecture/app/modules/common/components/input.dart';
import 'package:get/get.dart';
import 'package:flutter_architecture/app/modules/main/profile/profile_controller.dart';
import 'package:flutter_architecture/app/routes/routes_controller.dart';
import 'package:intl/intl.dart';

//ignore: must_be_immutable
class ProfilePage extends StatelessWidget {
  final RouteController routeController = Get.find();

  TextSelection endText(int? length) =>
      TextSelection.fromPosition(TextPosition(offset: length ?? 0));

  final controller = Get.put(ProfileController());
  final names = TextEditingController();
  final surnames = TextEditingController();
  final email = TextEditingController();
  final address = TextEditingController();
  final birthdayText = TextEditingController();
  late File? _image;
  final picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(title: Text('txt_d1bee5ff'.tr)),
      body: FullScreen(
        safeArea: true,
        child: GetBuilder<ProfileController>(builder: (_) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Center(child: UploadImage()),
              Column(children: [
                Input(
                  width: size.width * 0.8,
                  controller: TextEditingController(text: _.user.names)
                    ..selection = endText(_.user.names?.length),
                  debounce: 2000,
                  onChanged: _.updateNames,
                  labelText: 'Nombre',
                  margin: EdgeInsets.only(bottom: 5),
                ),
                Input(
                  width: size.width * 0.8,
                  controller: TextEditingController(text: _.user.surnames)
                    ..selection = endText(_.user.surnames?.length),
                  debounce: 2000,
                  onChanged: _.updateSurnames,
                  labelText: 'Apellido',
                  margin: EdgeInsets.only(bottom: 5),
                ),
                Input(
                  width: size.width * 0.8,
                  keyboardType: TextInputType.emailAddress,
                  controller: TextEditingController(text: _.user.email)
                    ..selection = endText(_.user.email?.length),
                  debounce: 3000,
                  onChanged: _.updateEmail,
                  labelText: 'correo electrónico',
                  margin: EdgeInsets.only(bottom: 5),
                ),
                Input(
                  width: size.width * 0.8,
                  controller: TextEditingController(text: _.user.address)
                    ..selection = endText(_.user.address?.length),
                  debounce: 2000,
                  onChanged: _.updateEmail,
                  labelText: 'Dirección',
                  margin: EdgeInsets.only(bottom: 5),
                ),
                Input(
                  width: size.width * 0.8,
                  controller: TextEditingController(
                    text: DateFormat('MM/dd/yyyy').format(
                      _.user.birthday ?? DateTime(DateTime.now().year - 18),
                    ),
                  ),
                  enabled: false,
                  labelText: 'Fecha de nacimiento',
                  margin: EdgeInsets.only(bottom: 5),
                ),
              ]),
              Text('')
            ],
          );
        }),
      ),
    );
  }
}
