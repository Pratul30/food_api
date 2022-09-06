import 'package:flutter/material.dart';
import 'package:flutter_app/api/restaurant.api.dart';
import 'package:flutter_app/providers/view%20models/geoId.dart';

import '../models/restaurant.dart';

class RestaurantVM with ChangeNotifier {
  GeoIdVM geoObj;

  RestaurantVM(this.geoObj);

  List<Restaurant> _restaurants = [];

  List<Restaurant> get getRestaurant {
    return [..._restaurants];
  }

  Future<void> loadAllRestaurants() async {
    final List<Restaurant> tempRestaurants = [];
    final geoId = geoObj.getgeoId;
    var sectionsList = [];
    final restaurantsData = await RestaurantApi.getAllRestaurants(geoId);
    if (restaurantsData[2] >= 200 || restaurantsData[2] <= 299) {
      sectionsList = restaurantsData[0]['data']
          ['AppPresentation_queryAppListV2'][0]['sections'];
      sectionsList
          .removeWhere((element) => !element.containsKey('singleCardContent'));
      sectionsList.forEach((element) {
        tempRestaurants.add(Restaurant(
          id: element['singleCardContent']['cardLink']['route']['typedParams']
              ['contentId'],
          name: element['singleCardContent']['cardTitle']['string'],
        ));
      });
      _restaurants.insertAll(0, tempRestaurants);
      print(_restaurants[0].name);
      notifyListeners();
    } else {
      print('error');
    }
  }

  //will provide all the list of restaurants
}
