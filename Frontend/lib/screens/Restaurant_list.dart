import 'package:flutter/material.dart';
import 'package:flutter_app/providers/view%20models/restaurant.dart';
import 'package:provider/provider.dart';

import '../widgets/RestaurantCard.dart';

import '../providers/models/restaurant.dart';
import '../widgets/cart_badge.dart';

class RestaurantListScreen extends StatelessWidget {
  const RestaurantListScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var res = Provider.of<RestaurantVM>(context);
    var restaurants = res.getRestaurant;

    final args =
        ModalRoute.of(context).settings.arguments as Map<String, Object>;

    final String cuisine = args == null
        ? 'All'
        : args['cuisine'] == ''
            ? 'All'
            : args['cuisine'];
    final List<Restaurant> filterList =
        args == null ? restaurants : args['list'];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Nearby $cuisine Restaurants',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
        ),
        backgroundColor: Colors.orange,
        actions: <Widget>[
          CartIconWithBadge(),
        ],
      ),
      body: ListView.builder(
        itemBuilder: ((context, index) => RestaurantCard(
              filterList[index].id,
              filterList[index].name,
              filterList[index].info,
              filterList[index].imageUrl,
              filterList[index].rating,
              filterList[index].totalReviews,
            )),
        itemCount: filterList.length,
      ),
    );
  }
}
