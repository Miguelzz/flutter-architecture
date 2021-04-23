import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:flutter_architecture/app/modules/common/components/button.dart';
import 'package:flutter_architecture/app/modules/common/components/fullscreen.dart';
import 'package:flutter_architecture/app/modules/common/components/input.dart';
import 'package:get/get.dart';
import 'package:flutter_architecture/app/modules/main/profile/profile_controller.dart';
import 'package:flutter_architecture/app/routes/routes_controller.dart';

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
    return Scaffold(
      appBar: AppBar(title: Text('txt_profile'.tr)),
      body: FullScreen(
        safeArea: true,
        child: GetBuilder<ProfileController>(builder: (_) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Center(
                child: InkWell(
                  onTap: () async {
                    await _showSelectionDialog(context, _);
                  },
                  child: CircleAvatar(
                    radius: 40.0,
                    backgroundImage: ExactAssetImage(
                        _.user.photo ?? "assets/images/user.png"),
                    backgroundColor: Colors.transparent,
                  ),
                ),
              ),
              Column(children: [
                Input(
                  controller: TextEditingController(text: _.user.names)
                    ..selection = endText(_.user.names?.length),
                  debounce: 2000,
                  onChanged: _.updateNames,
                  labelText: 'Cual es nombre?',
                  margin: EdgeInsets.only(bottom: 5),
                ),
                Input(
                  controller: TextEditingController(text: _.user.surnames)
                    ..selection = endText(_.user.surnames?.length),
                  debounce: 2000,
                  onChanged: _.updateSurnames,
                  labelText: 'Cual es tu Apellido?',
                  margin: EdgeInsets.only(bottom: 5),
                ),
                Input(
                  keyboardType: TextInputType.emailAddress,
                  controller: TextEditingController(text: _.user.email)
                    ..selection = endText(_.user.email?.length),
                  debounce: 3000,
                  onChanged: _.updateEmail,
                  labelText: 'Cual es tu correo electronico?',
                  margin: EdgeInsets.only(bottom: 5),
                ),
                Input(
                  controller: TextEditingController(text: _.user.address)
                    ..selection = endText(_.user.address?.length),
                  debounce: 2000,
                  onChanged: _.updateEmail,
                  labelText: 'Cual es tu dereccion?',
                  margin: EdgeInsets.only(bottom: 5),
                ),
                InkWell(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text('Cual es su fecha de nacimiento?'),
                            content: Container(
                              height: 150,
                              child: CupertinoDatePicker(
                                mode: CupertinoDatePickerMode.date,
                                initialDateTime: _.user.birthday ??
                                    DateTime(DateTime.now().year - 18),
                                onDateTimeChanged: (DateTime newDateTime) {
                                  _.user.birthday = newDateTime;
                                },
                              ),
                            ),
                            actions: [
                              ButtonLoading(
                                child: Text("OK"),
                                onPressed: () async {
                                  await _.updateBirthday(
                                      _.user.birthday!.toIso8601String());
                                  Navigator.of(context, rootNavigator: true)
                                      .pop();
                                },
                              ),
                            ],
                          );
                        });
                  }, // Handle your callback
                  child: Input(
                    controller: TextEditingController(
                        text: DateFormat('MM/dd/yyyy').format(_.user.birthday ??
                            DateTime(DateTime.now().year - 18))),
                    enabled: false,
                    labelText: 'Cual es su fecha de nacimiento?',
                    margin: EdgeInsets.only(bottom: 5),
                  ),
                )
              ])
            ],
          );
        }),
      ),
    );
  }

  Future<void> _showSelectionDialog(BuildContext context, ProfileController _) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: Text("Cambiar imagen de perfil"),
              content: SingleChildScrollView(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      child: Text("Gallery"),
                      onPressed: () {
                        _openGallery(context, _);
                      },
                    ),
                    ElevatedButton(
                      child: Text("Camera"),
                      onPressed: () {
                        _openCamera(context, _);
                      },
                    )
                  ],
                ),
              ));
        });
  }

  void _openGallery(BuildContext context, ProfileController _) async {
    var pickedFile = await picker.getImage(source: ImageSource.gallery);
    // setState(() {
    //   if (pickedFile != null) {
    //     _image = File(pickedFile.path);
    //   } else {
    //     print('No image selected.');
    //   }
    // });
    Navigator.of(context).pop();
  }

  void _openCamera(BuildContext context, ProfileController _) async {
    var pickedFile = await picker.getImage(source: ImageSource.camera);
    // setState(() {
    //   if (pickedFile != null) {
    //     _image = File(pickedFile.path);
    //   } else {
    //     print('No image selected.');
    //   }
    // });
    Navigator.of(context).pop();
  }
}
