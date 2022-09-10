import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class Location {
  //will give the location(latitude and longitude) of the user

  Map<String, double> userLocation = {};

  Future<void> getLocation() async {
    try {
      final permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        print('denied');
        return;
      }
      final res = await Geolocator.getCurrentPosition();
      userLocation.addAll({
        'latitude': res.latitude,
        'longitude': res.longitude,
      });
    } catch (e) {
      print('get $e');
    }
  }

  Map<String, double> get location {
    return userLocation;
  }
}
