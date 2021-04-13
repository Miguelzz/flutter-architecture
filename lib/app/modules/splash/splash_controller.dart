import 'dart:async';
import 'package:get/get.dart';

class SplashController extends GetxController {
  // final AuthenticationRepository _repository =
  //     Get.find<AuthenticationRepository>();

  @override
  void onInit() async {
    super.onInit();
    print('cargando servicios de la aplicacion');
    await Future.delayed(Duration(seconds: 1));
    Get.offAllNamed('/login');
  }
}
