import 'dart:async';
import 'package:get/get.dart';
import 'package:group/app/data/database/app-cache.dart';
import 'package:group/app/data/database/database.dart';
import 'package:group/app/data/models/user.dart';
import 'package:group/app/data/services/services.dart';

class LoginController extends GetxController {
  static final AppDatabase _db = Get.find<AppDatabase>();
  static final Services _services = Get.find<Services>();

  Future<void> login({required String prefix, required String phone}) async {
    AppCache.user = User(prefix: prefix, phone: phone);
    await _services.login(prefix, phone, 'code [code]').first;
    Get.toNamed('/validate-login');
  }

  Future<void> validateLogin({required String code}) async {
    final request = await _services
        .validateLogin(AppCache.user.prefix!, AppCache.user.phone!, code)
        .first;
    if (request!.token != null) {
      Get.offAllNamed('/');
      await _db.setRoute('/');
      await _db.setToken(request.token!);
      final user = await _services.me().first;
      AppCache.user = user!;
    } else {
      Get.toNamed('/login');
    }
  }

  @override
  void onInit() async {
    super.onInit();

    print('LOGIN');
  }
}
