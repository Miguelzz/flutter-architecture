import 'package:flutter_architecture/app/data/database/data-preloaded.dart';
import 'package:flutter_architecture/app/data/database/database.dart';
import 'package:flutter_architecture/app/data/models/token.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  static final AppDatabase _db = Get.find<AppDatabase>();

  late Token token;

  @override
  void onInit() async {
    super.onInit();
    this.token = DataPreloaded.token;

    update();
    print('HOME');
  }
}
