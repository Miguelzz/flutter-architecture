import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_architecture/app/config/app_interceptor.dart';
import 'package:get/get.dart';
import 'package:flutter_architecture/app/config/app-preloaded.dart';
import 'package:flutter_architecture/app/routes/routes.dart';
import 'package:flutter_architecture/app/translations/main_translation.dart';
import 'package:flutter_architecture/app/config/injections.dart';
import 'package:flutter_architecture/app/config/orchestrator.dart';
import 'app/config/app_events.dart';
import 'app/data/database/database.dart';

final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DependencyInjection.init();
  DataPreloaded.useMock = false;

  await AppDatabase.init();
  await DataPreloaded.init();
  await Orchestrator.init();
  await EventsApp.init();

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
        fallbackLocale: Locale('en', 'US'),
        theme: DataPreloaded.theme,
        getPages: routes,
      ),
    );
  }
}
