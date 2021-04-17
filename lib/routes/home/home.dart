import 'package:flutter/material.dart';
import 'package:putty/const.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(APP_NAME),
      ),
      body: _body,
    );
  }

  Widget get _body => Column(
        children: [
          Expanded(
            child: PageView(
              controller: _controller,
              onPageChanged: (idx) => setState(() => _currentPage = idx),
              children: [
                MapTab(),
                SearchTab(),
                AccountTab(),
              ],
            ),
          ),
          BottomNavigationBar(
            onTap: (idx) => setState(
              () => _controller.animateToPage(
                idx,
                duration: Duration(milliseconds: 250),
                curve: Curves.easeInOut,
              ),
            ),
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
