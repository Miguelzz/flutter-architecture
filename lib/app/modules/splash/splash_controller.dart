import 'package:flutter_architecture/app/data/database/data-preloaded.dart';
import 'package:flutter_architecture/app/data/database/database.dart';
import 'package:flutter_architecture/app/data/services/login/login_service.dart';
import 'package:flutter_architecture/app/routes/routes_controller.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  static final LoginService _loginService = Get.find<LoginService>();
  static final AppDatabase _db = Get.find<AppDatabase>();
  final RouteController route = Get.find();

  @override
  void onInit() async {
    super.onInit();
    try {
      print('cargando servicios de la aplicacion');

      final token = await _loginService
          .resetToken(
            DataPreloaded.user.prefix!,
            DataPreloaded.user.phone!,
            DataPreloaded.previousCode,
          )
          .first;
      print(token.toJson());
      await _db.setToken(token);
      route.offAllHome();
    } catch (e) {
      route.logout();
    }
  }
}
