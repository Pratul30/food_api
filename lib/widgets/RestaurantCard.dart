import 'package:flutter/material.dart';
import 'package:flutter_app/providers/location.dart';
import 'package:provider/provider.dart';

import '../providers/view models/geoId.dart';

class RestaurantCard extends StatelessWidget {
  RestaurantCard(this.name, this.id);

  final name;
  final id;

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
        child: Text('name: $name , contentId: $id'),
        elevation: 5,
      ),
    );
  }
}
