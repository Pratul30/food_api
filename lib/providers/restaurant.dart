import 'package:flutter/material.dart';

class Restaurant {
  String id;
  String name;
  String affordability;
  String imageUrl;
  String isOpen;
  double rating;
  int totalReviews;

  Restaurant({
    required this.id,
    required this.name,
    required this.affordability,
    required this.imageUrl,
    required this.isOpen,
    required this.rating,
    required this.totalReviews,
  });
}

class RestaurantVM with ChangeNotifier {
  List<Restaurant> resList = [];

  List<Restaurant> get restaurant {
    return [...resList];
  }
}
