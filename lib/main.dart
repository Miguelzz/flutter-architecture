import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:group/views/pages/main/setting/setting_controller.dart';
import 'package:group/views/routes/routes_controller.dart';
import 'package:group/views/pages/main/main_controller.dart';
import 'package:group/translations/main_translation.dart';
import 'database/initialize-cache.dart';
import 'views/routes/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await InitializeCache.instance.init(useMock: true);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Get.put(MainController());
    Get.put(SettingController());
    Get.put(RouteController());
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        translations: AppTranslations(),
        initialRoute: InitializeCache.instance.route,
        locale: InitializeCache.instance.locale,
        theme: InitializeCache.instance.theme,
        getPages: routes,
      ),
    );
  }
}
