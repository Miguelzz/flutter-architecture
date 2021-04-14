import 'package:dio/dio.dart';
import 'package:flutter_architecture/app/data/services/login/login_service.dart';
import 'package:flutter_architecture/app/data/services/users/user_service.dart';
import 'package:get/get.dart';
import 'package:flutter_architecture/app/data/database/database.dart';
import 'package:flutter_architecture/app/config/interceptors.dart';
import 'package:flutter_architecture/app/modules/main/main_controller.dart';
import 'package:flutter_architecture/app/modules/main/setting/setting_controller.dart';
import 'package:flutter_architecture/app/routes/routes_controller.dart';
import 'package:flutter_architecture/app/config/constants.dart';

class DependencyInjection {
  static void init() {
    Get.put(AppDatabase());
    Get.put(Dio(BaseOptions(baseUrl: Constants.BASE_URL)));
    Get.put(ServiceTemporary());

    // Services
    Get.put(LoginService());
    Get.put(UserService());

    // Controllers
    Get.put(MainController());
    Get.put(SettingController());
    Get.put(RouteController());
  }
}
