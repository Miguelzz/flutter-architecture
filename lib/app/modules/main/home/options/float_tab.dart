import '../home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget floatTab(int index) {
  final options = [
    // ONE
    FloatingActionButton(onPressed: () {}, child: Icon(Icons.looks_one)),
    // TWO
    FloatingActionButton(onPressed: () {}, child: Icon(Icons.home)),
    // THREE
    FloatingActionButton(onPressed: () {}, child: Icon(Icons.looks_two))
  ];

  return options[index];
}

class FloatTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) => GetBuilder<HomeController>(
        id: 'float_tap',
        builder: (_) => floatTab(_.indexTab),
      );
}
