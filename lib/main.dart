import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_architecture/app/data/database/data-preloaded.dart';
import 'package:flutter_architecture/app/routes/routes.dart';
import 'package:flutter_architecture/app/translations/main_translation.dart';
import 'package:flutter_architecture/app/config/injections.dart';
import 'package:flutter_architecture/app/config/orchestrator.dart';
import 'package:navigation_history_observer/navigation_history_observer.dart';
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
        navigatorObservers: [NavigationHistoryObserver()],
        debugShowCheckedModeBanner: false,
        translations: AppTranslations(),
        initialRoute: DataPreloaded.route,
        locale: DataPreloaded.locale,
        theme: DataPreloaded.theme,
        getPages: routes,
      ),
    );
  }
}

class RouteAwareWidget extends StatefulWidget {
  State<RouteAwareWidget> createState() => RouteAwareWidgetState();
}

// Implement RouteAware in a widget's state and subscribe it to the RouteObserver.
class RouteAwareWidgetState extends State<RouteAwareWidget> with RouteAware {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    //routeObserver.subscribe(this, ModalRoute.of(context));
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  void didPush() {
    print('didPush');
  }

  @override
  void didPopNext() {
    // Covering route was popped off the navigator.
  }

  @override
  Widget build(BuildContext context) => Container();
}
