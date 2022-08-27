import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';

class Location with ChangeNotifier {
  Map<String, double> userLocation = {};

  Future<void> getLocation() async {
    final permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      return;
    }
    final res = await Geolocator.getCurrentPosition();
    userLocation.addAll({
      'latitude': res.latitude,
      'longitude': res.longitude,
    });
    notifyListeners();
  }

  Map<String, double> get location {
    return userLocation;
  }
}
