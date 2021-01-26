import 'package:geolocator/geolocator.dart';

class Locator {
  Future<Position> getCurrentPosition() async {
    Position currentPosition;
    await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.best,
      forceAndroidLocationManager: true,
    ).then((Position position) {
      // print(position);
      currentPosition = position;
    }).catchError((err) {
      print('An error occured while getting current location : $err');
    });
    return currentPosition;
  }
}
