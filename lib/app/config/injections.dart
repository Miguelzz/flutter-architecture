import 'package:flutter_architecture/app/data/services/login/login_service.dart';
import 'package:flutter_architecture/app/data/services/users/user_service.dart';
import 'package:flutter_architecture/app/data/services/app/app_service.dart';
import 'package:flutter_architecture/app/modules/login/login_controller.dart';
import 'package:flutter_architecture/app/data/database/database.dart';
import 'package:flutter_architecture/app/config/app_interceptor.dart';
import 'package:flutter_architecture/app/modules/main/main_controller.dart';
import 'package:flutter_architecture/app/modules/main/home/home_controller.dart';
import 'package:flutter_architecture/app/modules/main/setting/setting_controller.dart';
import 'package:flutter_architecture/app/modules/main/profile/profile_controller.dart';
import 'package:flutter_architecture/app/routes/routes_controller.dart';
import 'package:flutter_architecture/app/config/constants.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';

class DependencyInjection {
  static void init() {
    Get.put(AppDatabase());
    Get.put(Dio(BaseOptions(baseUrl: Constants.BASE_URL)));
    Get.put(AppInterceptor());

    // Services
    Get.put(LoginService());
    Get.put(UserService());
    Get.put(AppService());

    // Controllers
    Get.put(RouteController());
    Get.put(LoginController());
    Get.put(ProfileController());
    Get.put(GlobalController());
    Get.put(HomeController());
    Get.put(SettingController());
  }
}
