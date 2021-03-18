import 'dart:async';
import 'package:get/get.dart';
import 'package:myArchitecture/database/database.dart';

class SplashController extends GetxController {
  static AppDatabase _database = AppDatabase.instance;

  Future<void> beforeStarting() async {}

  @override
  void onInit() async {
    super.onInit();
    print('cargando servicios de la aplicacion');
    await Future.delayed(Duration(seconds: 3));
    final route = (await _database.getDB('route')) ?? '/login';
    Get.toNamed('$route', arguments: "Hello World!");
  }
}
