import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myArchitecture/controller/home-controller.dart';
import 'package:myArchitecture/controller/main-controller.dart';
//import 'package:myArchitecture/services/user-service.dart';

class HomePage extends StatelessWidget {
  final mainController = Get.put(MainController());
  final homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Spacer(),
          GetBuilder<HomeController>(
              builder: (_) => Text('HOME ${homeController!.user?.toJson()}')),
          ElevatedButton(
            onPressed: () async {
              homeController!.getUser();
            },
            child: Text('GET USER'),
          ),
          ElevatedButton(
            onPressed: () async {
              mainController!.route('/login');
            },
            child: Text('IR A LOGIN'),
          )
        ],
      )),
    );
  }
}
