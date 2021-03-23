import 'dart:async';
import 'package:get/get.dart';
import 'package:group/database/database.dart';
import 'package:group/services/services.dart';

class LoginController extends GetxController {
  static final AppDatabase _cache = AppDatabase.instance;
  static final Services _services = Services.instance;

  Future<void> getUser() async {
    _services.getUser('8').api().listen((event) {
      update();
    });
  }

  @override
  void onInit() async {
    super.onInit();

    print('LOGIN');
  }
}
