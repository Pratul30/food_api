import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/view models/restaurant.dart';
import '../providers/models/restaurant.dart';

class SearchWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 10, top: 5, right: 10, bottom: 5),
      child: TextField(
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
            borderSide: BorderSide(
              width: 0,
              color: Colors.orange,
              style: BorderStyle.none,
            ),
          ),
          filled: true,
          prefixIcon: Icon(
            Icons.search,
            color: Colors.orange,
          ),
          fillColor: Color(0xFFFAFAFA),
          suffixIcon: Icon(
            Icons.sort,
            color: Colors.orange,
          ),
          hintStyle: new TextStyle(color: Color(0xFFd0cece), fontSize: 18),
          hintText: "Enter any restaurant or cuisine",
        ),
        onSubmitted: (value) {
          List<Restaurant> filterList;
          filterList = Provider.of<RestaurantVM>(context, listen: false)
              .filterRestaurantsBySearch(value.toLowerCase());
          Navigator.of(context).pushNamed('Restaurant_list', arguments: {
            'cuisine': value,
            'list': filterList,
          });
        },
      ),
    );
  }
}
