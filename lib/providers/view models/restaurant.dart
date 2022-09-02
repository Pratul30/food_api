import 'package:flutter/material.dart';
import 'package:flutter_app/providers/view%20models/geoId.dart';
import 'package:provider/provider.dart';

class RestaurantVM with ChangeNotifier {
  GeoIdVM geoObj;

  RestaurantVM(this.geoObj);

  //will provide all the list of restaurants
}
