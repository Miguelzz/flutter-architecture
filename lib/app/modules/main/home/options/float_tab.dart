import '../home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget floatTab(int index) {
  final options = [
    // ONE
    FloatingActionButton(onPressed: () {}, child: Icon(Icons.add)),
    // TWO
    FloatingActionButton(onPressed: () {}, child: Icon(Icons.remove)),
    // THREE
    FloatingActionButton(onPressed: () {}, child: Icon(Icons.delete))
  ];

  return options[index];
}

class FloatTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) => GetBuilder<HomeController>(
        builder: (_) => floatTab(_.index),
      );
}
