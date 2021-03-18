import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myArchitecture/controller/main-controller.dart';
import 'package:myArchitecture/services/manager.dart';
import 'package:myArchitecture/views/home/home.dart';
import 'database/database.dart';
import 'views/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final AppDatabase _database = AppDatabase.instance;
  await ManagerService.instance.init();
  final route = (await _database.getDB('route')) ?? '/splash';
  runApp(MyApp(route));
}

class MyApp extends StatelessWidget {
  final String route;
  MyApp(this.route);

  @override
  Widget build(BuildContext context) {
    Get.put(MainController());
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: route,
      getPages: routes,
      home: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: HomePage(),
      ),
    );
  }
}
