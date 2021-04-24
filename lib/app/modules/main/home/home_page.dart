import 'package:flutter/material.dart';
import 'package:flutter_architecture/app/config/constants.dart';
import 'package:flutter_architecture/app/config/theme/theme.dart';
import 'package:flutter_architecture/app/modules/main/home/home_body.dart';
import 'package:flutter_architecture/app/routes/routes_controller.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late TabController _controller;
  final RouteController _route = Get.find();
  ScrollController? _scrollViewController;

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 3, vsync: this);
    _controller.index = 1;
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
          return [
            SliverAppBar(
              title: Text(Constants.NAME_APP),
              pinned: true,
              floating: true,
              forceElevated: innerBoxIsScrolled,
              bottom: TabBar(
                tabs: [
                  Tab(icon: Text('OPCIÓN')),
                  Tab(icon: Text('txt_home'.tr)),
                  Tab(icon: Text('OPCIÓN')),
                ],
                controller: _controller,
              ),
              actions: [
                IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    showSearch(
                        context: context, delegate: DataSearch(listWords));
                  },
                ),
                PopupMenuButton(
                  child: Padding(
                    padding: EdgeInsets.only(right: 10),
                    child: Icon(Icons.more_vert),
                  ),
                  onSelected: (value) {
                    switch (value) {
                      case 'setting':
                        _route.nexSetting();
                        break;
                      case 'profile':
                        _route.nexProfile();
                        break;
                      case 'login':
                        _route.logout();
                        break;
                    }
                  },
                  itemBuilder: (context) {
                    return [
                      PopupMenuItem(
                        value: 'setting',
                        child: Text('txt_setting'.tr),
                      ),
                      PopupMenuItem(
                        value: 'profile',
                        child: Text('txt_profile'.tr),
                      ),
                      PopupMenuItem(
                        value: 'login',
                        child: Text('txt_login'.tr),
                      )
                    ];
                  },
                ),
              ],
            ),
          ];
        },
        body: TabBarView(
          children: [
            Text('opcion'),
            HomeBody(),
            Text('opcion'),
          ],
          controller: _controller,
        ),
      ),
    );
  }
}

List<ListWords> listWords = [
  ListWords('oneWord', 'OneWord definition'),
  ListWords('twoWord', 'TwoWord definition.'),
  ListWords('TreeWord', 'TreeWord definition'),
];

class ListWords {
  final String titlelist;
  final String definitionlist;

  ListWords(this.titlelist, this.definitionlist);
}

class DataSearch extends SearchDelegate<String> {
  final List<ListWords> listWords;

  DataSearch(this.listWords);

  @override
  List<Widget> buildActions(BuildContext context) {
    //Actions for app bar
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
    //leading icon on the left of the app bar
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
    // show when someone searches for something
    final suggestionList = query.isEmpty
        ? listWords
        : listWords; //.where((p) => p.startsWith(query)).toList();

    return ListView.builder(
      itemBuilder: (context, index) => ListTile(
        onTap: () {
          showResults(context);
        },
        trailing: Icon(Icons.remove_red_eye),
        title: RichText(
          text: TextSpan(
              text: suggestionList[index].titlelist.substring(0, query.length),
              style:
                  TextStyle(color: PRIMARY_COLOR, fontWeight: FontWeight.bold),
              children: [
                TextSpan(
                    text:
                        suggestionList[index].titlelist.substring(query.length),
                    style: TextStyle(color: Colors.grey))
              ]),
        ),
      ),
      itemCount: suggestionList.length,
    );
  }
}
