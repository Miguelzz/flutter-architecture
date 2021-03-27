import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:group/app/data/database/initialize-cache.dart';
import 'package:group/app/data/services/connectivity.dart';
import 'package:group/app/modules/splash/splash_binding.dart';
import 'package:group/app/routes/routes.dart';
import 'package:group/app/translations/main_translation.dart';
import 'package:group/app/utils/dependency_injection.dart';
import 'package:group/app/utils/orchestrator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  DependencyInjection.init();
  Orchestrator.init();

  await ConnetivityService.instance.init();
  await InitializeCache.instance.init(useMock: true);

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
        initialRoute: InitializeCache.instance.route,
        locale: InitializeCache.instance.locale,
        theme: InitializeCache.instance.theme,
        getPages: routes,
        initialBinding: SplashBinding(),
      ),
    );
  }
}
