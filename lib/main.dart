import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'Screens/PoliceListView.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(RoadlancePolice());
}

class RoadlancePolice extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Roadlance Police',
      home: PoliceListView(),
    );
  }
}
