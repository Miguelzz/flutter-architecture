import 'dart:async';
import 'package:flutter_architecture/app/config/app_events.dart';
import 'package:flutter_architecture/app/data/services/users/user_service.dart';
import 'package:get/get.dart';
import 'package:flutter_architecture/app/data/models/user.dart';

import 'package:flutter_architecture/app/routes/routes_controller.dart';

class ProfileController extends GetxController {
  static final UserService _userService = Get.find<UserService>();
  static final RouteController route = Get.find();

  User user = EventsApp.user;

  Future<void> home() async {
    await EventsApp.dialogLoading('Guardando...', () async {
      await updateNames(user.names ?? '');
      await updateSurnames(user.surnames ?? '');
      final date = user.birthday ?? DateTime(DateTime.now().year - 18);
      final dateFormat =
          "${date.year}/${date.month > 9 ? '' : '0'}${date.month}/${date.day > 9 ? '' : '0'}${date.day}";
      await updateBirthday(dateFormat);
    });

    route.offAllHome();
  }

  Future<void> updateNames(String value) async {
    User result = await _userService.updateNames(value).first;
    user.names = result.names;
    await EventsApp.changueUser(user);
  }

  Future<void> updateSurnames(String value) async {
    User result = await _userService.updateSurnames(value).first;
    user.surnames = result.surnames;
    await EventsApp.changueUser(user);
  }

  Future<void> updateEmail(String value) async {
    User result = await _userService.updateEmail(value).first;
    user.email = result.email;
    await EventsApp.changueUser(user);
  }

  Future<void> updateAddress(String value) async {
    User result = await _userService.updateAddress(value).first;
    user.address = result.address;
    await EventsApp.changueUser(user);
  }

  Future<void> updateBirthday(String value) async {
    User result = await _userService.updateBirthday(value).first;
    user.birthday = result.birthday;
    await EventsApp.changueUser(user);
  }

  @override
  void onInit() async {
    super.onInit();
    EventsApp.user$.listen((value) {
      user = value;
      update();
    });
    print('PROFILE');
  }
}
