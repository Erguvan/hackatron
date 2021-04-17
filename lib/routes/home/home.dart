import 'package:flutter/material.dart';
import 'package:putty/const.dart';
import 'package:putty/models/search_item.dart';
import 'package:putty/models/search_tab_click_controller.dart';
import 'package:putty/routes/home/account_tab.dart';

import 'package:putty/routes/home/map_tab.dart';
import 'package:putty/routes/home/search_tab.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PageController _controller = PageController();

  Map<String, IconData> _bottomNavigatorRoutes = {
    'Map': Icons.map_outlined,
    'Search': Icons.search_outlined,
    'Account': Icons.person_outlined,
  };

  int _currentPage = 0;

  void _onSearchClick(SearchItem item) {
    _controller.animateToPage(
      0,
      duration: Duration(milliseconds: 250),
      curve: Curves.easeInOut,
    );
    Future.delayed(
      Duration(milliseconds: 500),
      () => _mapTabState.currentState?.goToLocation(item),
    );
  }

  GlobalKey<MapTabState> _mapTabState = GlobalKey<MapTabState>();
  late SearchTabClickController _searchTabClickController;

  @override
  void initState() {
    super.initState();
    _searchTabClickController = SearchTabClickController(
      onClick: _onSearchClick,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(APP_NAME),
        elevation: 0,
      ),
      body: _body,
    );
  }

  Widget get _body => Column(
        children: [
          Expanded(
            child: PageView(
              physics: NeverScrollableScrollPhysics(),
              controller: _controller,
              onPageChanged: (idx) => setState(() => _currentPage = idx),
              children: [
                MapTab(key: _mapTabState),
                SearchTab(searchTabClickController: _searchTabClickController),
                AccountTab(),
              ],
            ),
          ),
          BottomNavigationBar(
            onTap: (idx) {
              _controller.animateToPage(
                idx,
                duration: Duration(milliseconds: 250),
                curve: Curves.easeInOut,
              );
              setState(() {});
            },
            currentIndex: _currentPage,
            items: _bottomNavigatorRoutes.keys
                .map<BottomNavigationBarItem>(
                  (key) => BottomNavigationBarItem(
                    icon: Icon(_bottomNavigatorRoutes[key]),
                    label: key,
                  ),
                )
                .toList(),
          )
        ],
      );
}
