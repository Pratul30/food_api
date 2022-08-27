import 'package:flutter/material.dart';

import '../widgets/RestaurantCard.dart';

class RestaurantListScreen extends StatelessWidget {
  const RestaurantListScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Our restaurants',
        ),
        brightness: Brightness.light,
        backgroundColor: Color.fromRGBO(255, 102, 102, 0.85),
      ),
      body: ListView.builder(
        itemBuilder: ((context, index) => RestaurantCard()),
        itemCount: 3,
      ),
    );
  }
}
