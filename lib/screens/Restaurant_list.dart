import 'package:flutter/material.dart';
import 'package:flutter_app/providers/view%20models/restaurant.dart';
import 'package:provider/provider.dart';

import '../widgets/RestaurantCard.dart';

class RestaurantListScreen extends StatelessWidget {
  const RestaurantListScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var res = Provider.of<RestaurantVM>(context);
    var restaurants = res.getRestaurant;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Nearby Restaurants',
        ),
        brightness: Brightness.light,
        backgroundColor: Color.fromRGBO(255, 102, 102, 0.85),
      ),
      body: ListView.builder(
        itemBuilder: ((context, index) => RestaurantCard(
              restaurants[index].id,
              restaurants[index].name,
              restaurants[index].info,
              restaurants[index].imageUrl,
              restaurants[index].rating,
              restaurants[index].totalReviews,
            )),
        itemCount: restaurants.length,
      ),
    );
  }
}
