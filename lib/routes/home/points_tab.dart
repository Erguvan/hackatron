import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:firebase/firebase.dart';
import 'package:flutter/material.dart';
import 'package:putty/models/points.dart';
import 'package:putty/models/search_tab_click_controller.dart';
import 'package:putty/widgets/custombody.dart';

class PointsTab extends StatefulWidget {
  PointsTab({required this.searchTabClickController});

  final SearchTabClickController searchTabClickController;

  @override
  _PointsTabState createState() => _PointsTabState();
}

class _PointsTabState extends State<PointsTab> {
  @override
  Widget build(BuildContext context) {
    Query query = FirebaseFirestore.instance.collection('points');

    return Scaffold(
        body: BaseBodyLayout(
            child: StreamBuilder<QuerySnapshot>(
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
                  itemBuilder: (context, index) =>
                      Points(querySnapshot.docs[index]),
                );
              },
            ),
            asset: "assets/backpattern.jpg"));
  }
}
