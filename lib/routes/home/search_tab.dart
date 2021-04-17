import 'package:flutter/material.dart';
import 'package:putty/models/search_item.dart';
import 'package:putty/models/search_tab_click_controller.dart';

class SearchTab extends StatefulWidget {
  SearchTab({required this.searchTabClickController});

  final SearchTabClickController searchTabClickController;

  @override
  _SearchTabState createState() => _SearchTabState();
}

class _SearchTabState extends State<SearchTab> {
  TextEditingController _searchController = TextEditingController();

  List<SearchItem> _dummyItems = [
    SearchItem(
      name: 'Karabaş',
      photo: 'https://images.dog.ceo/breeds/spaniel-welsh/n02102177_3289.jpg',
      location: '30.25, 36.82',
    ),
    SearchItem(
      name: 'İsimsiz',
      photo: 'https://images.dog.ceo/breeds/shiba/shiba-10.jpg',
      location: '35.45, -47.96',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(8),
          child: TextFormField(
            controller: _searchController,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.search_outlined),
            ),
          ),
        ),
        Expanded(
          child: ListView(
            children: _dummyItems.map<ListTile>((e) => _getSearchTabItem(e)).toList(),
          ),
        ),
      ],
    );
  }

  ListTile _getSearchTabItem(SearchItem item) => ListTile(
        onTap: () => widget.searchTabClickController.onClick(item),
        leading: AspectRatio(
          aspectRatio: 1,
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.transparent,
                width: 0,
              ),
              borderRadius: BorderRadius.circular(100),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: Image.network(
                  item.photo,
                  width: 48,
                  height: 48,
                ).image,
              ),
            ),
          ),
        ),
        title: Text(item.name),
        subtitle: Text(item.location),
      );
}
