import 'package:flutter/material.dart';
import 'package:flutter_app/screens/FoodOrderScreen.dart';
import 'package:flutter_app/screens/HomeScreen.dart';
import 'package:flutter_app/screens/Restaurant_list.dart';
import 'package:flutter_app/screens/userScreen.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import '../providers/view models/restaurant.dart';

class BottomNavBarWidget extends StatefulWidget {
  @override
  _BottomNavBarWidgetState createState() => _BottomNavBarWidgetState();
}

class _BottomNavBarWidgetState extends State<BottomNavBarWidget> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserGeoId();
  }

  void getUserGeoId() async {
    var resObj = Provider.of<RestaurantVM>(context, listen: false);
    await resObj.loadAllRestaurants();
  }

  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _selectedIndex == 0
          ? HomeScreen()
          : _selectedIndex == 1
              ? const RestaurantListScreen()
              : _selectedIndex == 2
                  ? FoodOrderScreen()
                  : const UserScreen(),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.near_me), label: 'Near By'),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart), label: 'Cart'),
          BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.user), label: 'Account'),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.orange,
        onTap: (int index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}
