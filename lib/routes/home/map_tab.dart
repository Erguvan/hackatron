import 'package:flutter/material.dart';
import 'package:latlng/latlng.dart';
import 'package:map/map.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:location/location.dart';

class MapTab extends StatefulWidget {
  MapTab({Key? key}) : super(key: key);

  @override
  MapTabState createState() => MapTabState();
}

class MapTabState extends State<MapTab> {
  void goToLocation(String location) {
    try {
      var latlng = location.split(',');
      controller.center = LatLng(
        double.parse(latlng[0].trim()),
        double.parse(latlng[1].trim()),
      );
      setState(() {});
    } catch (e) {}
  }

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
        body: Stack(
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

                      return Image.network(
                        url,
                        fit: BoxFit.cover,
                      );
                    },
                  ),
                  Center(
                    child: Icon(Icons.close, color: Colors.red),
                  ),
                ],
              ),
            ),
            Positioned(
              top: 10,
              right: 15,
              left: 15,
              child: Container(
                color: Colors.white,
                child: Row(
                  children: <Widget>[
                    IconButton(
                      splashColor: Colors.grey,
                      icon: Icon(Icons.menu),
                      onPressed: () {},
                    ),
                    Expanded(
                      child: TextField(
                        cursorColor: Colors.black,
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.go,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 15),
                            hintText: "Search..."),
                      ),
                    ),
                    /*Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: CircleAvatar(
                        backgroundColor: Colors.deepPurple,
                        child: Text('RD'),
                      ),
                    ),*/
                  ],
                ),
              ),
            ),
          ],
        ),
        floatingActionButton: Stack(children: <Widget>[
          Align(
            alignment: Alignment.bottomRight,
            child: Column(
              children: <Widget>[
                FloatingActionButton(
                  onPressed: _gotoDefault,
                  tooltip: 'My Location',
                  child: Icon(Icons.my_location),
                ),
                SizedBox(height: 8),
                FloatingActionButton(
                  onPressed: _onDoubleTap,
                  tooltip: 'Bigger',
                  child: Icon(Icons.add),
                ),
                SizedBox(height: 8),
                FloatingActionButton(
                  onPressed: _onNegativeDoubleTap,
                  tooltip: 'Smaller',
                  child: Icon(Icons.remove),
                ),
              ],
            ),
          )
        ]));
  }
}
