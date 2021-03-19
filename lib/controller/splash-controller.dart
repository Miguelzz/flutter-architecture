import 'dart:async';
import 'package:get/get.dart';
import 'package:myArchitecture/database/initialize-cache.dart';

class SplashController extends GetxController {
  @override
  void onInit() async {
    super.onInit();
    print('cargando servicios de la aplicacion');
    await Future.delayed(Duration(seconds: 3));
    Get.toNamed(InitializeCache.instance.route);
  }
}
