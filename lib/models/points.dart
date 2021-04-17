import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

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
    return Text('${point['name']} (${point['mission']})',
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
        child: Row(children: [
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: Text('Importance: ${importance}'),
          ),
        ]));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4, top: 4),
      child: InkWell(
        onTap: () {
          print("click");
          //aha buraya harita zıkkımı eklenecek
        },
        child: Row(children: <Widget>[urgency, Expanded(child: details)]),
      ),
    );
  }
}
