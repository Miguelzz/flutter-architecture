import 'dart:async';
import 'package:get/get.dart';
import 'package:group/app/data/database/app-cache.dart';
import 'package:group/app/data/database/database.dart';
import 'package:group/app/data/models/user.dart';
import 'package:group/app/data/services/services.dart';

class ProfileController extends GetxController {
  static final Services _services = Get.find<Services>();
  static final AppDatabase _db = Get.find<AppDatabase>();

  User? user;

  Future<void> getUser() async {}

  @override
  void onInit() async {
    super.onInit();
    user = AppCache.user;
    print('PROFILE');
  }
}
