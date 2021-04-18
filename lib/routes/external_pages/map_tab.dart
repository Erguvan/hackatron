import 'package:flutter/material.dart';
import 'package:latlng/latlng.dart';
import 'package:map/map.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:location/location.dart';
import 'package:geocoding/geocoding.dart';
import 'package:putty/models/search_item.dart';

class MapTab extends StatefulWidget {
  MapTab(SearchItem searchItem, {Key? key}) : super(key: key);

  @override
  MapTabState createState() => MapTabState();
}

class MapTabState extends State<MapTab> {
  void goToLocation(SearchItem item) {
    try {
      var latlng = item.location.split(',');
      controller.center = LatLng(
        double.parse(latlng[0].trim()),
        double.parse(latlng[1].trim()),
      );
      _lastSearchItem = item;
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (_) => _bottomSheet,
      );
      setState(() {});
    } catch (e) {}
  }

  TextEditingController _searchController = TextEditingController();
  FocusNode _searchFocusNode = FocusNode();
  late SearchItem _lastSearchItem;

  final controller = MapController(
    location: LatLng(39.92524128151174, 32.83692009925839),
  );

  void _gotoDefault() {
    controller.center = LatLng(39.92524128151174, 32.83692009925839);
  }

  void _onDoubleTap() {
    controller.zoom += 0.5;
  }

  void _onNegativeDoubleTap() {
    controller.zoom -= 0.5;
  }

  late Offset _dragStart;
  double _scaleStart = 1.0;
  void _onScaleStart(ScaleStartDetails details) {
    _searchFocusNode.unfocus();
    _dragStart = details.focalPoint;
    _scaleStart = 1.0;
  }

  void _onScaleUpdate(ScaleUpdateDetails details) {
    final scaleDiff = details.scale - _scaleStart;
    _scaleStart = details.scale;

    if (scaleDiff > 0) {
      controller.zoom += 0.02;
    } else if (scaleDiff < 0) {
      controller.zoom -= 0.02;
    } else {
      final now = details.focalPoint;
      final diff = now - _dragStart;
      _dragStart = now;
      controller.drag(diff.dx, diff.dy);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        alignment: Alignment.topCenter,
        children: <Widget>[
          GestureDetector(
            onDoubleTap: _onDoubleTap,
            onScaleStart: _onScaleStart,
            onScaleUpdate: _onScaleUpdate,
            onScaleEnd: (details) {
              print(
                  "Location: ${controller.center.latitude}, ${controller.center.longitude}");
            },
            child: Stack(
              children: [
                Map(
                  controller: controller,
                  builder: (context, x, y, z) {
                    final url =
                        'https://www.google.com/maps/vt/pb=!1m4!1m3!1i$z!2i$x!3i$y!2m3!1e0!2sm!3i420120488!3m7!2sen!5e1105!12m4!1e68!2m2!1sset!2sRoadmap!4e0!5m1!1e0!23i4111425';
                    //print(url);

                    return Image.network(
                      url,
                      fit: BoxFit.cover,
                    );
                  },
                ),
                Center(
                  child: Icon(
                    Icons.place,
                    color: Colors.red,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(8),
            child: Theme(
              data: Theme.of(context).copyWith(splashColor: Colors.transparent),
              child: TextFormField(
                focusNode: _searchFocusNode,
                controller: _searchController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.black.withAlpha(150),
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.search_outlined),
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          FloatingActionButton(
            onPressed: _onDoubleTap,
            tooltip: 'Bigger',
            child: Icon(Icons.add),
            mini: true,
          ),
          SizedBox(height: 8),
          FloatingActionButton(
            onPressed: _onNegativeDoubleTap,
            tooltip: 'Smaller',
            child: Icon(Icons.remove),
            mini: true,
          ),
          SizedBox(height: 8),
          FloatingActionButton(
            onPressed: _gotoDefault,
            tooltip: 'My Location',
            child: Icon(Icons.my_location),
          ),
        ],
      ),
    );
  }

  Widget get _bottomSheet => ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
        child: Container(
          padding: EdgeInsets.all(16),
          color: Colors.black,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Padding(
                  padding: EdgeInsets.only(bottom: 8),
                  child: Container(
                    height: 4,
                    width: 56,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      color: Color(0x66DEDEDE),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16),
              Text(
                _lastSearchItem.name,
                style: Theme.of(context).textTheme.headline6,
              ),
              SizedBox(height: 16),
              FutureBuilder(
                future: placemarkFromCoordinates(
                  controller.center.latitude,
                  controller.center.longitude,
                ),
                builder: (_, AsyncSnapshot<List<Placemark>> snapshot) {
                  var tempLocation =
                      '${controller.center.latitude}, ${controller.center.longitude}';
                  try {
                    if (snapshot.data == null) {
                      if (snapshot.hasError) {
                        throw snapshot.error!;
                      }
                      return Text(tempLocation);
                    }
                    var location = snapshot.data?.first;
                    return Text(location?.name ?? tempLocation);
                  } catch (e) {
                    return Text(tempLocation);
                  }
                },
              ),
            ],
          ),
        ),
      );
}
