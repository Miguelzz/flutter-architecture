import 'package:flutter/material.dart';
import 'package:flutter_architecture/app/config/constants.dart';
import 'package:flutter_architecture/app/modules/main/home/home_controller.dart';
import 'package:flutter_architecture/app/modules/main/home/options/float_tab.dart';
import 'package:flutter_architecture/app/modules/main/home/options/search_tab.dart';
import 'package:flutter_architecture/app/modules/main/home/tabs/tab_content_one.dart';
import 'package:flutter_architecture/app/modules/main/home/tabs/tab_content_three.dart';
import 'package:flutter_architecture/app/modules/main/home/tabs/tab_content_two.dart';
import 'package:flutter_architecture/app/modules/main/home/options/menu_tab.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late TabController _controller;

  final HomeController homeController = Get.find();

  ScrollController? _scrollViewController;

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 3, vsync: this);
    _controller.index = homeController.index;
    _controller.addListener(() {
      homeController.changueTab(_controller.index);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: NestedScrollView(
          controller: _scrollViewController,
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            print("Selected Index: " + _controller.index.toString());
            return [
              SliverAppBar(
                title: Text(Constants.NAME_APP),
                pinned: true,
                floating: true,
                forceElevated: innerBoxIsScrolled,
                bottom: TabBar(
                  tabs: [
                    Tab(icon: Text('ONE')),
                    Tab(icon: Text('txt_2a0c1b1a'.tr.toUpperCase())),
                    Tab(icon: Text('THREE')),
                  ],
                  controller: _controller,
                ),
                actions: [
                  IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () {
                      showSearch(
                        context: context,
                        delegate: DataSearch(),
                      );
                    },
                  ),
                  MenuTap()
                ],
              ),
            ];
          },
          body: TabBarView(
            children: [
              TabContentOne(),
              TabContentTow(),
              TabContentThree(),
            ],
            controller: _controller,
          ),
        ),
        floatingActionButton: FloatTab());
  }
}
