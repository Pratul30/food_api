import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import '../location.dart';

class GeoIdVM with ChangeNotifier {
  // will provide the geoid of the user

  int geoId = 0;

  int get getgeoId {
    return geoId;
  }

  Future<void> getGeoId() async {
    var locObj = new Location();
    await locObj.getLocation();
    final Map<String, double> location = locObj.location;

    final url = Uri.https(
      'travel-advisor.p.rapidapi.com',
      '/restaurants/list-by-latlng',
      {
        'latitude': location['latitude'],
        'longitude': location['longitude'],
        'limit': 30,
        'currency': 'USD',
        'distance': 2,
        'open_now': false,
        'lunit': 'km',
        'lang': 'en_US'
      }.map((key, value) => MapEntry(key, value.toString())),
    );
    final response = await http.get(url, headers: {
      'X-RapidAPI-Key': '1be9677502msh0742fed2f9b77c6p1218d6jsn2d1420205cf8',
      'X-RapidAPI-Host': 'travel-advisor.p.rapidapi.com',
    });
    final res = json.decode(response.body);
    geoId = int.parse(res['data'][0]['ranking_geo_id']);
    notifyListeners();
  }
}
