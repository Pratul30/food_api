import 'package:flutter/cupertino.dart';

class Restaurant {
  String name;
  String affordability;
  String imageUrl;
  String isOpen;
  double rating;
  int totalReviews;

  Restaurant({
    this.name,
    this.affordability,
    this.imageUrl,
    this.isOpen,
    this.rating,
    this.totalReviews,
  });
}

class RestaurantVM with ChangeNotifier {
  List<Restaurant> resList = [];

  List<Restaurant> get restaurant {
    return [...resList];
  }
}
