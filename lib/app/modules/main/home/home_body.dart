import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_architecture/app/modules/common/components/fullscreen.dart';
import 'package:flutter_architecture/app/modules/main/home/home_controller.dart';
import 'package:flutter_architecture/app/modules/main/main_controller.dart';
import 'package:get/get.dart';
import 'package:flutter_architecture/app/routes/routes_controller.dart';

class HomeBody extends StatelessWidget {
  final RouteController routeController = Get.find();
  final MainController mainController = Get.find();

  final controller = Get.put(HomeController());
  final names = TextEditingController();
  final surnames = TextEditingController();
  final email = TextEditingController();
  final address = TextEditingController();
  final birthdayText = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return FullScreen(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Center(
            child: GetBuilder<HomeController>(
              builder: (_) => Text(_.countdown),
            ),
          ),
          Container(
            width: size.width * 0.7,
            child: GetBuilder<HomeController>(
              builder: (_) => Text('${_.token.toJson()} ${_.user.names}'),
            ),
          ),
        ],
      ),
    );
  }

  TextSelection endText(int? length) =>
      TextSelection.fromPosition(TextPosition(offset: length ?? 0));
}
