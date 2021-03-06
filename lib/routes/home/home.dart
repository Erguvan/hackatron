import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:putty/const.dart';
import 'package:putty/models/search_item.dart';
import 'package:putty/models/search_tab_click_controller.dart';
import 'package:putty/routes/home/account_tab.dart';
import 'package:putty/routes/external_pages/map_tab.dart';
import 'package:putty/routes/home/animals_tab.dart';
import 'package:putty/routes/home/points_tab.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PageController _controller = PageController();

  Map<String, IconData> _bottomNavigatorRoutes = {
    'Animal': Icons.pets,
    'Points': Icons.explore,
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
        backwardsCompatibility: false,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
        ),
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
                Padding(
                  padding: EdgeInsets.all(0),
                  child: AnimalTab(
                      searchTabClickController: _searchTabClickController),
                ),
                PointsTab(searchTabClickController: _searchTabClickController),
                SignInGoogle(),
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
