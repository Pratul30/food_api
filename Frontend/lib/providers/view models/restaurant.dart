import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:flutter_app/api/restaurant.api.dart';
import '../location.dart';

import '../models/restaurant.dart';

class RestaurantVM with ChangeNotifier {
  int geoId;

  List<Restaurant> _restaurants = [];

  List<Restaurant> get getRestaurant {
    return [..._restaurants];
  }

  bool loadingRestaurantList = false;

  void printres() async {
    final mainStr = _restaurants[0].imageUrl.substring(8);
    final encodedList = mainStr.split('/');
    final encodedPath = encodedList[0];
    final unencodedPath = mainStr.substring(mainStr.indexOf('/'));
    final url = Uri.https(encodedPath, unencodedPath, {
      'w': '100',
      'h': '100',
      's': '1',
    });
    final res = await http.get(url);
  }

  Future<void> loadAllRestaurants() async {
    loadingRestaurantList = true;
    var locObj = new Location();
    try {
      await locObj.getLocation();
      final Map<String, double> location = locObj.location;
      print(location['latitude']);
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
        'X-RapidAPI-Key': 'd37b196933msh4361f5106d5ba66p108077jsne7efe530c45b',
        'X-RapidAPI-Host': 'travel-advisor.p.rapidapi.com',
      });
      final res = json.decode(response.body);
      List temp = res['data'];
      temp.forEach((element) {
        if (element['ranking_geo_id'] != null) {
          geoId = int.parse(element['ranking_geo_id']);
        }
      });
      print(geoId);
      final List<Restaurant> tempRestaurants = [];
      var sectionsList = [];
      final restaurantsData = await RestaurantApi.getAllRestaurants(geoId);
      if (restaurantsData[2] >= 200 || restaurantsData[2] <= 299) {
        sectionsList = restaurantsData[0]['data']
            ['AppPresentation_queryAppListV2'][0]['sections'];
        sectionsList.removeWhere(
            (element) => !element.containsKey('singleCardContent'));
        sectionsList.forEach((element) {
          tempRestaurants.add(Restaurant(
            id: element['singleCardContent']['cardLink']['route']['typedParams']
                ['contentId'],
            name: element['singleCardContent']['cardTitle']['string'],
            info: element['singleCardContent']['primaryInfo']['text'],
            imageUrl: element['singleCardContent']['cardPhoto']['sizes']
                ['urlTemplate'],
            rating: element['singleCardContent']['bubbleRating']['rating'],
            totalReviews: int.parse(element['singleCardContent']['bubbleRating']['numberReviews']['string']),
          ));
        });
        _restaurants.insertAll(0, tempRestaurants);
        loadingRestaurantList = false;
        notifyListeners();
      } else {
        print('error');
      }
    } catch (e) {
      print('res $e');
    }
  }

  List<Restaurant> filterRestaurantsByCuisine(String cuisine) {
    List<Restaurant> filterList = [];
    _restaurants.forEach((element) {
      if (element.info.contains(cuisine)) {
        filterList.add(element);
      }
    });
    return filterList;
  }

  List<Restaurant> filterRestaurantsBySearch(String keyword) {
    List<Restaurant> filterList = [];
    _restaurants.forEach((element) {
      final infoLowerCase = element.info.toLowerCase();
      final nameLowerCase = element.name.toLowerCase();
      if (infoLowerCase.contains(keyword)) {
        filterList.add(element);
      } else if (nameLowerCase.contains(keyword)) {
        filterList.add(element);
      }
    });
    return filterList;
  }

  //will provide all the list of restaurants
}
