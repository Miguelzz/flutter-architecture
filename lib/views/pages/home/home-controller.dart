import 'dart:async';
import 'package:get/get.dart';
import 'package:group/database/database.dart';
import 'package:group/models/user.dart';
import 'package:group/services/services.dart';

class HomeController extends GetxController {
  static final Services _services = Services.instance;
  static final AppDatabase _cache = AppDatabase.instance;

  User? user;

  Future<void> getUser() async {
    _services.getUser('8').api().listen((event) {
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
    _services.getUser('4').cache().listen((event) {
      user = event;
      update();
    });

    print('HOME');
  }
}
