import 'dart:async';
import 'package:get/get.dart';
import 'package:flutter_architecture/app/data/database/data-preloaded.dart';
import 'package:flutter_architecture/app/data/database/database.dart';
import 'package:flutter_architecture/app/data/models/user.dart';

class ProfileController extends GetxController {
  static final AppDatabase _db = Get.find<AppDatabase>();

  User? user;

  Future<void> getUser() async {}

  @override
  void onInit() async {
    super.onInit();
    user = DataPreloaded.user;
    print('PROFILE');
  }
}
