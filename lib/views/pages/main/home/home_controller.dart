import 'package:get/get.dart';
import 'package:group/database/database.dart';
import 'package:group/services/services.dart';

class HomeController extends GetxController {
  static final Services _services = Services.instance;
  static final AppDatabase _cache = AppDatabase.instance;

  String? token;

  @override
  void onInit() async {
    super.onInit();
    this.token = await _cache.getToken() ?? 'NO TOKEN';
    update();
    print('HOME');
  }
}
