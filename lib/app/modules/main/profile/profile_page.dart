import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_architecture/app/data/models/user.dart';
import 'package:flutter_architecture/app/modules/common/components/box.dart';
import 'package:flutter_architecture/app/modules/common/components/button.dart';
import 'package:flutter_architecture/app/modules/common/components/fullscreen.dart';
import 'package:flutter_architecture/app/modules/common/components/input.dart';
import 'package:get/get.dart';
import 'package:flutter_architecture/app/modules/main/profile/profile_controller.dart';
import 'package:flutter_architecture/app/routes/routes_controller.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class ShowProps {
  late bool showNames = false,
      showSurnames = false,
      showEmail = false,
      showBirthday = false,
      showAddress = false;

  final String? names;
  final String? surnames;
  final String? email;
  final String? address;
  final DateTime? birthday;
  ShowProps(
      this.names, this.surnames, this.birthday, this.email, this.address) {
    showNames = !empity(names);
  }

  bool empity(String? value) {
    return value != null && value != '';
  }
}

class _ProfilePageState extends State<ProfilePage> {
  final RouteController routeController = Get.find();
  final controller = Get.put(ProfileController());
  final names = TextEditingController();
  final surnames = TextEditingController();
  final email = TextEditingController();
  final address = TextEditingController();

  final List<String> showParams = [];

  late DateTime birthday;
  @override
  void initState() {
    final user = controller?.user;
    names..text = user?.names ?? '';
    surnames..text = user?.surnames ?? '';
    birthday = user?.birthday ?? DateTime(DateTime.now().year - 18);
    email..text = user?.email ?? '';
    address..text = user?.address ?? '';

    super.initState();
  }

  bool empity(String? value) {
    return !(value != null && value != '');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FullScreen(
        safeArea: true,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Center(child: Text('txt_profile'.tr)),

            Text('${controller?.user?.toJson()}'),

            GetBuilder<ProfileController>(builder: (_) {
              return Column(children: [
                Input(
                  controller: names,
                  labelText: 'Cual es nombre?',
                  margin: EdgeInsets.only(bottom: 5),
                ),
                Input(
                  controller: surnames,
                  labelText: 'Cual es tu Apellido?',
                  margin: EdgeInsets.only(bottom: 5),
                ),
                Input(
                  controller: email,
                  labelText: 'Cual es tu correo electronico?',
                  margin: EdgeInsets.only(bottom: 5),
                ),
                Input(
                  controller: address,
                  labelText: 'Cual es tu dereccion?',
                  margin: EdgeInsets.only(bottom: 5),
                ),
                Box(
                  child: Column(
                    children: [
                      Text('Cual es su fecha de nacimiento?'),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: 150,
                        child: CupertinoDatePicker(
                          mode: CupertinoDatePickerMode.date,
                          initialDateTime: birthday,
                          onDateTimeChanged: (DateTime newDateTime) {
                            birthday = newDateTime;
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ]);
            }),

            ButtonLoading(
              onPressed: () async {
                await controller?.updateUser(User(
                  names: names.text,
                  surnames: surnames.text,
                  email: email.text,
                  address: address.text,
                  birthday: birthday,
                ));
              },
              child: Text('Actualizar'),
            ),
            // ElevatedButton(
            //   onPressed: () async {
            //     routeController.nexBack();
            //   },
            //   child: Text('txt_home'.tr),
            // )
          ],
        ),
      ),
    );
  }
}
