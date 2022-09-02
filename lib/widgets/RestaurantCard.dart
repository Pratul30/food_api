import 'package:flutter/material.dart';
import 'package:flutter_app/providers/location.dart';
import 'package:provider/provider.dart';

import '../providers/view models/geoId.dart';

class RestaurantCard extends StatefulWidget {
  const RestaurantCard({Key key}) : super(key: key);

  @override
  State<RestaurantCard> createState() => _RestaurantCardState();
}

class _RestaurantCardState extends State<RestaurantCard> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      margin: EdgeInsets.only(
        top: 20,
        left: 10,
        right: 10,
      ),
      width: double.infinity,
      child: Card(
        child: Text('restaurant image, name, affordability'),
        elevation: 5,
      ),
    );
  }
}
