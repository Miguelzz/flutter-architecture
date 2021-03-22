import 'dart:async';
import 'package:get/get.dart';
import 'package:group/database/database.dart';

class RegisterController extends GetxController {
  static final AppDatabase _cache = AppDatabase.instance;
  int step = 0;

  @override
  void onInit() async {
    super.onInit();

    print('Register');
  }
}
