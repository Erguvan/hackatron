import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:putty/models/search_item.dart';
import 'package:putty/routes/external_pages/map_tab.dart';

/*
Point
name: String
mission: String
location: double
details: String
importance: int
*/

/// A single Point row.
class Points extends StatelessWidget {
  /// Contains all snapshot data for a given point.
  final DocumentSnapshot snapshot;

  //final SearchTabClickController searchTabClickController;

  /// Initialize a [Move] instance with a given [DocumentSnapshot].
  Points(this.snapshot);

  /// Returns the [DocumentSnapshot] data as a a [Map].
  Map<String, dynamic> get point {
    return snapshot.data()!;
  }

  /// Returns the point photo.
  Widget get urgency {
    String importance;
    switch (point['importance']) {
      case 1:
        importance = "not urgent";
        break;
      case 2:
        importance = "mostly urgent";
        break;
      case 3:
        importance = "very urgent";
        break;
      case 4:
        importance = "vital";
        break;
      default:
        importance = "important";
        break;
    }
    return SizedBox(
      width: 100,
      child: Center(
        child: AspectRatio(
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
                image: AssetImage(
                  "assets/${importance}.png".replaceAll(RegExp(' '), '_'),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Returns point details.
  Widget get details {
    return Padding(
        padding: const EdgeInsets.only(left: 8, right: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            name,
            description,
          ],
        ));
  }

  /// Return the point name.
  Widget get name {
    return Text('${point['name']}',
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold));
  }

  /// Returns metadata about the point.
  Widget get description {
    late String importance;
    switch (point['importance']) {
      case 1:
        importance = "not urgent";
        break;
      case 2:
        importance = "mostly urgent";
        break;
      case 3:
        importance = "very urgent";
        break;
      case 4:
        importance = "vital";
        break;
      default:
        importance = "important";
        break;
    }
    return Padding(
        padding: const EdgeInsets.only(top: 8),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Text('Importance: ${importance}'),
              Text('Mission: ${point['mission']}'),
            ]));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4, top: 4),
      child: InkWell(
        onTap: () {
          print("click");
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Scaffold(
                      appBar: PreferredSize(
                        child: Stack(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    Theme.of(context)
                                        .scaffoldBackgroundColor
                                        .withAlpha(200),
                                    Colors.transparent,
                                  ],
                                ),
                              ),
                            ),
                            AppBar(
                              // brightness: Brightness.light,
                              backwardsCompatibility: false,
                              systemOverlayStyle: SystemUiOverlayStyle(
                                statusBarColor: Colors.transparent,
                              ),
                              backgroundColor: Colors.transparent,
                              elevation: 0,
                              leading: GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Icon(
                                  Icons.arrow_back,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                        preferredSize: Size.fromHeight(56),
                      ),
                      body: MapTab(new SearchItem(
                          photo: point['name'], // It is fuzzy and not needed.
                          name: point['name'],
                          location: point['location'])))));
          //aha buraya harita zıkkımı eklenecek
        },
        child: Row(children: <Widget>[
          urgency,
          Expanded(child: details),
          Icon(Icons.place),
        ]),
      ),
    );
  }
}
