import 'package:flutter_architecture/app/modules/main/home/home_controller.dart';
import 'package:flutter_architecture/app/routes/routes_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

//  ItemSearch(route: '/profile', tags: ['one', 'uno'], item: Text('ONE 3')),
//       ItemSearch(route: '/profile', tags: ['two', 'dos'], item: Text('TWO 3')),
//       ItemSearch(
//           route: '/profile', tags: ['tree', 'tres'], item: Text('THREE 3')),

class ItemSearch {
  final Widget item;
  final String route;

  ItemSearch({
    required this.route,
    required this.item,
  });
}

class DataSearch extends SearchDelegate<String> {
  final HomeController _controller = Get.find();

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            query = '';
          })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    _controller.searchTab(query);
    return IconButton(
        icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow,
          progress: transitionAnimation,
        ),
        onPressed: () {
          close(context, 'null');
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    // show some result based on the selection

    return Center(
      child: Text(query),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (_) => Column(
        children: _.listSearch,
      ),
    );
  }
}
