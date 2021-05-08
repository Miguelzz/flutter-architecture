import 'dart:async';

import 'package:flutter_architecture/app/data/models/demo.dart';
import 'package:flutter_architecture/app/modules/main/home/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_architecture/app/routes/routes_controller.dart';
import 'package:get/get.dart';

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
  final RouteController _route = Get.find();
  Timer _debounce = Timer(Duration(milliseconds: 700), () {});

  DataSearch() {
    if (query == '') {
      Future.delayed(Duration(milliseconds: 10))
          .then((value) => query = _controller.query);
    }
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            _controller.searchTab('');
          })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    if (_debounce.isActive) _debounce.cancel();
    _debounce = Timer(Duration(milliseconds: 700), () {
      _controller.searchTab(query);
    });

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
    return ContentSearch();
  }
}

class ContentSearch extends StatefulWidget {
  @override
  _ContentSearchState createState() => _ContentSearchState();
}

class _ContentSearchState extends State<ContentSearch> {
  final ScrollController _scrollController = ScrollController();
  final HomeController _controller = Get.find();
  final RouteController _route = Get.find();

  @override
  void initState() {
    super.initState();
    bool stop = false;
    _scrollController.addListener(() async {
      final endPage = _scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent;
      if (endPage && !stop) {
        stop = true;
        await _controller.searchNextTab();
        stop = false;
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      id: 'search_tap',
      builder: (_) {
        if (_.indexTab == 0)
          return ListView.builder(
            controller: _scrollController,
            itemCount: _.tapOneSearch.length,
            itemBuilder: (context, index) =>
                itemSearchOne(_.tapOneSearch[index]),
          );

        if (_.indexTab == 1)
          return ListView.builder(
            controller: _scrollController,
            itemCount: _.tapHomeSearch.length,
            itemBuilder: (context, index) =>
                itemSearchOne(_.tapHomeSearch[index]),
          );

        if (_.indexTab == 2)
          return ListView.builder(
            controller: _scrollController,
            itemCount: _.tapThreeSearch.length,
            itemBuilder: (context, index) =>
                itemSearchOne(_.tapThreeSearch[index]),
          );
        else
          return Container();
      },
    );
  }

  Widget itemSearchOne(Demo item) {
    return InkWell(
      child: ListTile(
        title: Text(item.title ?? ''),
        subtitle: Text('ONE'),
        leading: CircleAvatar(
          backgroundImage: NetworkImage(item.images?[0].url ?? ''),
        ),
        onTap: _route.nexProfile,
      ),
      onTap: () {
        _route.nexRoute('/profile');
      },
    );
  }

  Widget itemSearchHome(Demo item) {
    return InkWell(
      child: ListTile(
        title: Text(item.title ?? ''),
        subtitle: Text('HOME'),
        leading: CircleAvatar(
          backgroundImage: NetworkImage(item.images?[0].url ?? ''),
        ),
        onTap: _route.nexProfile,
      ),
      onTap: () {
        _route.nexRoute('/profile');
      },
    );
  }

  Widget itemSearchThree(Demo item) {
    return InkWell(
      child: ListTile(
        title: Text(item.title ?? ''),
        subtitle: Text('THREE'),
        leading: CircleAvatar(
          backgroundImage: NetworkImage(item.images?[0].url ?? ''),
        ),
        onTap: _route.nexProfile,
      ),
      onTap: () {
        _route.nexRoute('/profile');
      },
    );
  }
}
