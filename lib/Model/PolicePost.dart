import 'package:cloud_firestore/cloud_firestore.dart';

class PolicePost {
  PolicePost({
    this.violation,
    this.description,
    this.numberPlate,
    this.status,
    this.email,
    this.uid,
    this.phoneNumber,
    this.mediaUrls,
    this.mediaDetails,
    this.latitude,
    this.longitude,
    this.uploadTime,
    this.documentName,
  });

  final String documentName;
  final String violation;
  final String description;
  final String numberPlate;
  final String status;
  final String email;
  final String uid;
  final String phoneNumber;
  final List mediaUrls;
  final List mediaDetails;
  final double latitude;
  final double longitude;
  final String uploadTime;
}
