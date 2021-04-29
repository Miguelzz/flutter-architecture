import 'package:flutter/material.dart';
import 'package:flutter_architecture/app/modules/main/home/home_controller.dart';
import 'package:flutter_architecture/app/routes/routes_controller.dart';
import 'package:get/get.dart';

class TabContentHome extends StatelessWidget {
  final RouteController routeController = Get.find();
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      initState: (state) {
        _scrollController.addListener(() {
          if (_scrollController.position.pixels ==
              _scrollController.position.maxScrollExtent) {
            print('aaaaaa');
          }
        });
      },
      builder: (_) => Text('_.index'),
    );

    // ListView.builder(
    //     padding: EdgeInsets.all(0),
    //     itemCount: list.length,
    //     itemBuilder: (context, index) {
    //       return ListTile(
    //         title: Text(list[index]),
    //         subtitle: Text('nada'),
    //         leading: CircleAvatar(
    //           backgroundImage: NetworkImage(Constants.IMAGE_DEMO),
    //         ),
    //         onTap: () {},
    //       );
    //     });
  }
}
