import 'package:get/get.dart';
import 'package:group/app/data/database/database.dart';
import 'package:group/app/data/services/services.dart';

class HomeController extends GetxController {
  static final Services _services = Services.instance;
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
