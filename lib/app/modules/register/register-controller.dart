import 'dart:async';
import 'package:get/get.dart';
import 'package:flutter_architecture/app/data/database/database.dart';

class RegisterController extends GetxController {
  static final AppDatabase _db = Get.find<AppDatabase>();
  int step = 0;

  @override
  void onInit() async {
    super.onInit();

    print('Register');
  }
}
