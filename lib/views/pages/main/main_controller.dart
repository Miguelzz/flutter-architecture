import 'package:get/get.dart';
import 'package:group/database/database.dart';

class MainController extends GetxController {
  static final AppDatabase _cache = AppDatabase.instance;

  @override
  void onInit() async {
    super.onInit();
    print('MAIN');
  }
}
