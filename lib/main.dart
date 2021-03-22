import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:group/views/routes/routes-controller.dart';
import 'package:group/views/pages/main-controller.dart';
import 'package:group/translations/main-translation.dart';
import 'database/initialize-cache.dart';
import 'views/routes/routes-pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await InitializeCache.instance.init(useMock: true);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Get.put(MainController());
    Get.put(RouteController());

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      translations: AppTranslations(),
      initialRoute: InitializeCache.instance.route,
      locale: InitializeCache.instance.locale,
      theme: InitializeCache.instance.theme,
      getPages: routes,
    );
  }
}
