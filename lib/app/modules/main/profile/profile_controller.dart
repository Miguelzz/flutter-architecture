import 'dart:async';
import 'package:get/get.dart';
import 'package:group/app/data/database/database.dart';
import 'package:group/app/data/models/user.dart';
import 'package:group/app/data/services/services.dart';

class ProfileController extends GetxController {
  static final Services _services = Services.instance;
  static final AppDatabase _db = Get.find<AppDatabase>();

  User? user;

  Future<void> getUser() async {
    _services.getUser('2').listen((event) {
      user = event;

      print('***********');
      print(user?.toJson());
      print('***********');
      update();
    });
  }

  @override
  void onInit() async {
    super.onInit();
    _services.getUser('4').listen((event) {
      user = event;
      update();
    });

    print('PROFILE');
  }
}
