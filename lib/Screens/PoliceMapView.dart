import 'dart:async';
import 'package:Roadlance_Police/Model/Locator.dart';
import 'package:Roadlance_Police/Model/PolicePost.dart';
import 'package:Roadlance_Police/Screens/PostDisplay.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PoliceMapView extends StatefulWidget {
  PoliceMapView({
    this.goto,
  });

  final LatLng goto;

  @override
  _PoliceMapViewState createState() => _PoliceMapViewState();
}

class _PoliceMapViewState extends State<PoliceMapView> {
  Completer<GoogleMapController> mapController = Completer();
  LatLng currentPosition;
  Set<Marker> markers = {};
  MapType mapType = MapType.normal;
  double currentZoom = 20.0;

  @override
  void initState() {
    super.initState();
    setCurrentPosition();
  }

  void setCurrentPosition() async {
    Locator locator = Locator();
    if (widget.goto == null) {
      Position pos = await locator.getCurrentPosition();
      setState(() {
        currentPosition = LatLng(pos.latitude, pos.longitude);
      });
    } else {
      setState(() {
        currentPosition = widget.goto;
        currentZoom = 35.0;
      });
    }
  }

  void onMapCreated(GoogleMapController controller) {
    mapController.complete(controller);
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    firestore.collection('Police').get().then(
      (QuerySnapshot snap) {
        snap.docs.forEach(
          (DocumentSnapshot doc) {
            Map data = doc.data();
            addMarker(
              PolicePost(
                violation: data['Violation'],
                description: data['Description'],
                numberPlate: data['NumberPlate'],
                status: data['Status'],
                email: data['Email'],
                uid: data['Uid'],
                phoneNumber: data['PhoneNumber'],
                mediaUrls: data['Media-Urls'],
                mediaDetails: data['Media-Details'],
                latitude: data['Latitude'],
                longitude: data['Longitude'],
                uploadTime: data['UploadTime'],
                documentName: doc.id,
              ),
            );
          },
        );
      },
    );
  }

  void onCameraMove(CameraPosition position) {
    currentPosition = position.target;
  }

  void addMarker(PolicePost post) {
    setState(() {
      markers.add(
        Marker(
          markerId: MarkerId(LatLng(post.latitude, post.longitude).toString()),
          position: LatLng(post.latitude, post.longitude),
          infoWindow: InfoWindow(
            title: post.violation,
            snippet: post.uploadTime.toString(),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PostDisplay(post: post),
                ),
              );
            },
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Violations'),
        backgroundColor: Color(0xFF312c42),
      ),
      body: Stack(
        children: [
          GoogleMap(
            onMapCreated: onMapCreated,
            initialCameraPosition: CameraPosition(
              target: currentPosition,
              zoom: currentZoom,
            ),
            mapType: mapType,
            markers: markers,
            onCameraMove: onCameraMove,
          )
        ],
      ),
    );
  }
}
