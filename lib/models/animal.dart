import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:putty/models/search_tab_click_controller.dart';

/*
Animal

name: String
photo: String
age: double
kind: String
description: String
location: Geolocation
*/

/// A single animal row.
class Animal extends StatelessWidget {
  /// Contains all snapshot data for a given animal.
  final DocumentSnapshot snapshot;

  //final SearchTabClickController searchTabClickController;

  /// Initialize a [Move] instance with a given [DocumentSnapshot].
  Animal(this.snapshot);

  /// Returns the [DocumentSnapshot] data as a a [Map].
  Map<String, dynamic> get animal {
    return snapshot.data()!;
  }

  /// Returns the animal photo.
  Widget get poster {
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
                image: Image.network(
                  animal['photo'],
                  width: 48,
                  height: 48,
                ).image,
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Returns animal details.
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

  /// Return the animal name.
  Widget get name {
    return Text('${animal['name']} (${animal['age']})',
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold));
  }

  /// Returns metadata about the animal.
  Widget get description {
    return Padding(
        padding: const EdgeInsets.only(top: 8),
        child: Row(children: [
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: Text('Kind: ${animal['kind']}'),
          ),
          // Text('Description: ${animal['description']}'),
        ]));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4, top: 4),
      child: InkWell(
        onTap: () {
          print("click");
        },
        child: Row(children: <Widget>[poster, Expanded(child: details)]),
      ),
    );
  }
}
