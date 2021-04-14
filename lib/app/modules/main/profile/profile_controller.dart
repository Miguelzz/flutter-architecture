import 'dart:async';
import 'package:flutter_architecture/app/data/services/users/user_service.dart';
import 'package:get/get.dart';
import 'package:flutter_architecture/app/data/database/data-preloaded.dart';
import 'package:flutter_architecture/app/data/database/database.dart';
import 'package:flutter_architecture/app/data/models/user.dart';

class ProfileController extends GetxController {
  static final AppDatabase _db = Get.find<AppDatabase>();
  static final UserService _userService = Get.find<UserService>();

  User? user;

  Future<void> getUser() async {
    final slave = await _userService.getUser().first;
    print(slave);
  }

  @override
  void onInit() async {
    super.onInit();
    user = DataPreloaded.user;
    print('PROFILE');
  }
}
