import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myArchitecture/controller/main-controller.dart';
import 'package:myArchitecture/services/manager.dart';
import 'package:myArchitecture/views/home/home.dart';
import 'database/initialize-cache.dart';
import 'views/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await InitializeCache.instance.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Get.put(MainController());
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: InitializeCache.instance.route,
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
