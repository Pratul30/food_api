import 'package:flutter/material.dart';
import 'package:flutter_app/providers/view%20models/restaurant.dart';
import 'package:provider/provider.dart';

import '../widgets/RestaurantCard.dart';

class RestaurantListScreen extends StatelessWidget {
  const RestaurantListScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var res = Provider.of<RestaurantVM>(context).getRestaurant;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Our restaurants',
        ),
        brightness: Brightness.light,
        backgroundColor: Color.fromRGBO(255, 102, 102, 0.85),
      ),
      body: ListView.builder(
        itemBuilder: ((context, index) => Container(
              child: Text('name: ${res[0].name}'),
            )),
        itemCount: 3,
      ),
    );
  }
}
