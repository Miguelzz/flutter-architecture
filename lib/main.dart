import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_architecture/app/data/database/data-preloaded.dart';
import 'package:flutter_architecture/app/modules/splash/splash_binding.dart';
import 'package:flutter_architecture/app/routes/routes.dart';
import 'package:flutter_architecture/app/translations/main_translation.dart';
import 'package:flutter_architecture/app/config/injections.dart';
import 'package:flutter_architecture/app/config/orchestrator.dart';
import 'app/data/database/database.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DependencyInjection.init();

  await AppDatabase.init();
  await DataPreloaded.init();
  await Orchestrator.init();
  DataPreloaded.useMock = false;

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
        initialRoute: DataPreloaded.route,
        locale: DataPreloaded.locale,
        theme: DataPreloaded.theme,
        getPages: routes,
        initialBinding: SplashBinding(),
      ),
    );
  }
}
