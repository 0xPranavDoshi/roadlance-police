import 'package:Roadlance_Police/Screens/PoliceMapView.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../Model/PolicePost.dart';
import '../Components/PostCard.dart';

class PoliceListView extends StatefulWidget {
  @override
  _PoliceListViewState createState() => _PoliceListViewState();
}

class _PoliceListViewState extends State<PoliceListView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF312c42),
        title: Text('Violations'),
        centerTitle: true,
        leading: Container(),
      ),
      backgroundColor: Color(0xFF4b4266),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('Police')
            .orderBy('UploadTime', descending: true)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return ListView(
              children:
                  snapshot.data.docs.map((QueryDocumentSnapshot document) {
                var data = document.data();
                return PostCard(
                  post: PolicePost(
                    violation: data['Violation'],
                    description: data['Description'],
                    status: data['Status'],
                    mediaUrls: data['Media-Urls'],
                    mediaDetails: data['Media-Details'],
                    numberPlate: data['NumberPlate'],
                    latitude: data['Latitude'],
                    longitude: data['Longitude'],
                    email: data['Email'],
                    phoneNumber: data['PhoneNumber'],
                    uid: data['Uid'],
                    uploadTime: data['UploadTime'],
                    documentName: document.id,
                  ),
                );
              }).toList(),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PoliceMapView(),
            ),
          );
        },
        child: Icon(
          Icons.location_pin,
        ),
      ),
    );
  }
}
