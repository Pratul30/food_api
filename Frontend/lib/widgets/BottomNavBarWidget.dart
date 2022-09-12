import 'package:flutter/material.dart';
import 'package:flutter_app/screens/HomeScreen.dart';
import 'package:flutter_app/screens/userScreen.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BottomNavBarWidget extends StatefulWidget {
  @override
  _BottomNavBarWidgetState createState() => _BottomNavBarWidgetState();
}

class _BottomNavBarWidgetState extends State<BottomNavBarWidget> {
  @override
  Widget build(BuildContext context) {
    int _selectedIndex = 3;

    return Scaffold(

      body: _selectedIndex == 0
        ? HomeScreen()
        : _selectedIndex == 1
        ? const Center()
        : _selectedIndex == 2
        ? const Center()
        :  const UserScreen(),
  
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home),label: 'Home'),
          BottomNavigationBarItem( icon: Icon(Icons.near_me), label: 'Near By'),
          BottomNavigationBarItem(icon: Icon(Icons.card_giftcard),label: 'Cart'),
          BottomNavigationBarItem(icon: Icon(FontAwesomeIcons.user),label: 'Account'),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.orange,
        onTap: (int index){
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
    
  }
}
