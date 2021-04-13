import 'package:get/get.dart';
import 'package:flutter_architecture/app/data/database/database.dart';

class HomeController extends GetxController {
  static final AppDatabase _db = Get.find<AppDatabase>();

  String? token;

  @override
  void onInit() async {
    super.onInit();
    this.token = await _db.getToken() ?? 'NO TOKEN';
    update();
    print('HOME');
  }
}
