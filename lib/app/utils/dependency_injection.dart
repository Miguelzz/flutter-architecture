import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:group/app/data/database/database.dart';
import 'package:group/app/data/provider/authentication_api.dart';
import 'package:group/app/data/repository/authentication_repository.dart';
import 'package:group/app/modules/main/main_controller.dart';
import 'package:group/app/modules/main/setting/setting_controller.dart';
import 'package:group/app/routes/routes_controller.dart';
import 'package:group/app/utils/constants.dart';

class DependencyInjection {
  static void init() {
    Get.put(AppDatabase());
    Get.put(Dio(BaseOptions(baseUrl: Constants.BASE_URL)));
    Get.put(AuthenticationApi());
    Get.put(AuthenticationRepository());

    Get.put(MainController());
    Get.put(SettingController());
    Get.put(RouteController());
  }
}
