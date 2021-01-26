import 'package:Roadlance_Police/Model/PolicePost.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DbUpdater {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  void approvePost(PolicePost post, int updateAmount) async {
    String firstMediaTime;
    Timestamp userUploadTime;

    await FirebaseFirestore.instance
        .collection('Users')
        .doc(post.uid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        var data = documentSnapshot.data();
        print('Document data: $data');
        firstMediaTime = data['FirstMediaTime'];
      } else {
        print('Document does not exist on the database');
      }
    });

    await FirebaseFirestore.instance
        .collection('Users')
        .doc(post.uid)
        .collection('Posts')
        .doc(firstMediaTime.toString())
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        var data = documentSnapshot.data();
        print('Post Document data: $data');
        userUploadTime = data['UploadTime'];
      } else {
        print('Document does not exist on the database');
      }
    });

    firestore
        .collection('Users')
        .doc(post.uid)
        .get()
        .then((DocumentSnapshot snap) {
      print('DATA IS : ${snap.data()}');
      int updateBalance = snap.data()['CurrentBalance'] + updateAmount;
      firestore.collection('Users').doc(post.uid).update({
        'CurrentBalance': updateBalance,
      });
      firestore
          .collection('Users')
          .doc(post.uid)
          .collection('Posts')
          .doc(firstMediaTime)
          .update({
        'Status': 'Approved',
      });
      firestore
          .collection('Users')
          .doc(post.uid)
          .collection('Posts')
          .doc(firstMediaTime)
          .update({
        'Status': 'Approved',
      });

      firestore
          .collection('Police')
          .doc(userUploadTime.toDate().toString())
          .delete()
          .then((value) => print("Post Deleted"))
          .catchError((error) => print("Failed to delete user: $error"));
    });
  }

  void declinePost(PolicePost post) async {
    String firstMediaTime;
    Timestamp userUploadTime;

    await FirebaseFirestore.instance
        .collection('Users')
        .doc(post.uid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        var data = documentSnapshot.data();
        print('Document data: $data');
        firstMediaTime = data['FirstMediaTime'];
      } else {
        print('Document does not exist on the database');
      }
    });

    await FirebaseFirestore.instance
        .collection('Users')
        .doc(post.uid)
        .collection('Posts')
        .doc(firstMediaTime.toString())
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        var data = documentSnapshot.data();
        print('Post Document data: $data');
        userUploadTime = data['UploadTime'];
      } else {
        print('Document does not exist on the database');
      }
    });

    firestore
        .collection('Users')
        .doc(post.uid)
        .collection('Posts')
        .doc(firstMediaTime)
        .update({
      'Status': 'Declined',
    });

    firestore
        .collection('Police')
        .doc(userUploadTime.toDate().toString())
        .delete()
        .then((value) => print("User Deleted"))
        .catchError((error) => print("Failed to delete user: $error"));
  }
}
