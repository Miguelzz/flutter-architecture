import 'dart:async';
import 'package:get/get.dart';
import 'package:group/app/data/database/database.dart';
import 'package:group/app/data/services/services.dart';

class LoginController extends GetxController {
  static final AppDatabase _db = Get.find<AppDatabase>();
  static final Services _services = Services.instance;

  int count = 0;
  Future<void> addTem() async {
    count++;
    await _db.setTemporary('x/$count', {'init': count});
  }

  Future<void> login({required String prefix, required String phone}) async {
    _services.login(prefix, phone).listen((token) async {
      Get.offAllNamed('/');
      await _db.setRoute('/');

      print('*****************');
      print(token);
      print('*****************');
      await _db.setToken(token!);
    }, onError: (error) async {
      Get.offAllNamed('/register');
      await _db.setRoute('/register');
    });
  }

  Future<void> getUser() async {
    _services.getUser('8').listen((event) {
      update();
    });
  }

  @override
  void onInit() async {
    super.onInit();

    print('LOGIN');
  }
}
