import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:firebase/firebase.dart';
import 'package:flutter/material.dart';
import 'package:putty/models/animal.dart';
import 'package:putty/models/search_tab_click_controller.dart';

class AnimalTab extends StatefulWidget {
  AnimalTab({required this.searchTabClickController});

  final SearchTabClickController searchTabClickController;

  @override
  _AnimalTabState createState() => _AnimalTabState();
}

class _AnimalTabState extends State<AnimalTab> {
  @override
  Widget build(BuildContext context) {
    Query query = FirebaseFirestore.instance.collection('putties');

    return Scaffold(
        body: StreamBuilder<QuerySnapshot>(
      stream: query.snapshots(),
      builder: (context, stream) {
        if (stream.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (stream.hasError) {
          return Center(child: Text(stream.error.toString()));
        }

        QuerySnapshot querySnapshot = stream.data!;

        return ListView.builder(
          itemCount: querySnapshot.size,
          itemBuilder: (context, index) => Animal(querySnapshot.docs[index]),
        );
      },
    ));
  }
}
