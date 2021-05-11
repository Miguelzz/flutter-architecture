import 'package:flutter/material.dart';
import 'package:flutter_architecture/app/config/constants.dart';
import 'package:flutter_architecture/app/data/models/demo.dart';
import 'package:flutter_architecture/app/modules/main/home/home_controller.dart';
import 'package:flutter_architecture/app/routes/routes_controller.dart';
import 'package:get/get.dart';

class TabContentHome extends StatelessWidget {
  final RouteController routeController = Get.find();
  final ScrollController _scrollController = ScrollController();

  String _getMainImage(List<ImageCloudinary>? images) {
    String url = Constants.IMAGE_DEMO;

    if (images != null && images.length > 0) {
      if (images[0].url != null &&
          images[0].url != null &&
          images[0].url != '') {
        url = images[0].url!;
      }
    }

    return url;
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      id: 'tap-home',
      initState: (state) {
        _scrollController.addListener(() {
          if (_scrollController.position.pixels ==
              _scrollController.position.maxScrollExtent) {
            print('aaaaaa');
          }
        });
      },
      builder: (_) => ListView.builder(
        padding: EdgeInsets.all(0),
        itemCount: _.tapHomeContent.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(_.tapHomeContent[index].title ?? ''),
            subtitle: Text('nada'),
            leading: CircleAvatar(
              backgroundImage:
                  NetworkImage(_getMainImage(_.tapHomeContent[index].images)),
            ),
            onTap: () {},
          );
        },
      ),
    );
  }
}
