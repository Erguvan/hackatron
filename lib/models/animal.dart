import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

/*
Animal

name: String
photo: String
age: double
specie: String
description: String

*/

/// A single animal row.
class Animal extends StatelessWidget {
  /// Contains all snapshot data for a given animal.
  final DocumentSnapshot snapshot;

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
      child: Center(child: Image.network(animal['photo'])),
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
            child: Text('Specie: ${animal['specie']}'),
          ),
          Text('Description: ${animal['description']}'),
        ]));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4, top: 4),
      child: Row(
        children: [poster, Flexible(child: details)],
      ),
    );
  }
}
