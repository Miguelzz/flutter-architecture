import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'controllers/services/manager.dart';
import 'controllers/services/user-service.dart';
import 'controllers/store/store.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ManagerService.instance.init();
  await Store.instance.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: 'splash',
        //routes: routes,
        home: Scaffold(
          body: Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Spacer(),
              ElevatedButton(
                onPressed: () async {
                  print('*********');
                  print((await UserService.instance.getUsers()).id);
                  print((await UserService.instance.getUsers()).title);
                  print('*********');
                },
                child: Text('CONTAINED BUTTON'),
              )
            ],
          )),
        ),
      ),
    );
  }
}
