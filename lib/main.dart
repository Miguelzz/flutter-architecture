import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:group/app/data/database/app-cache.dart';
import 'package:group/app/modules/splash/splash_binding.dart';
import 'package:group/app/routes/routes.dart';
import 'package:group/app/translations/main_translation.dart';
import 'package:group/app/utils/dependency_injection.dart';
import 'package:group/app/utils/orchestrator.dart';
import 'app/data/database/database.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DependencyInjection.init();

  await AppDatabase.init();
  await AppCache.init();
  await Orchestrator.init();
  AppCache.useMock = false;

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
        // FocusScopeNode currentFocus = FocusScope.of(context);
        // if (!currentFocus.hasPrimaryFocus) currentFocus.unfocus();
      },
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        translations: AppTranslations(),
        initialRoute: AppCache.route,
        locale: AppCache.locale,
        theme: AppCache.theme,
        getPages: routes,
        initialBinding: SplashBinding(),
      ),
    );
  }
}
