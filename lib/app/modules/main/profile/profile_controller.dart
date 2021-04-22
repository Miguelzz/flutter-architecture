import 'dart:async';
import 'package:flutter_architecture/app/data/services/users/user_service.dart';
import 'package:get/get.dart';
import 'package:flutter_architecture/app/data/database/data-preloaded.dart';
import 'package:flutter_architecture/app/data/database/database.dart';
import 'package:flutter_architecture/app/data/models/user.dart';

class ProfileController extends GetxController {
  static final AppDatabase _db = Get.find<AppDatabase>();
  static final UserService _userService = Get.find<UserService>();

  late User user;

  Future<void> getUser() async {
    user = await _userService.getUser().first;
    await _db.setUser(user);
    update();
  }

  Future<void> updateNames(String value) async {
    User result = await _userService.updateNames(value).first;
    user.names = result.names;
    update();
  }

  Future<void> updateSurnames(String value) async {
    User result = await _userService.updateSurnames(value).first;
    user.surnames = result.surnames;
    update();
  }

  Future<void> updateEmail(String value) async {
    User result = await _userService.updateEmail(value).first;
    user.email = result.email;
    update();
  }

  Future<void> updateAddress(String value) async {
    User result = await _userService.updateAddress(value).first;
    user.address = result.address;
    update();
  }

  Future<void> updateBirthday(String value) async {
    User result = await _userService.updateBirthday(value).first;
    user.birthday = result.birthday;
    update();
  }

  @override
  void onInit() async {
    super.onInit();
    user = DataPreloaded.user;
    print('PROFILE');
  }
}
