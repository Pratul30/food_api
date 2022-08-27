import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rapyd_app/view/account.view.dart';
import 'package:rapyd_app/view/cart.view.dart';
import 'package:rapyd_app/view/home.view.dart';
import 'package:rapyd_app/view/nearby.view.dart';

class BottomBar extends StatefulWidget {
  @override
  _BottomBarState createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {

  int _index = 0; // default index

  @override
  Widget build(BuildContext context) {

    return Scaffold(


      body: _index == 0
        ? HomeView()
        : _index == 1
          ? NearByView()
          : _index == 2
            ? CartView()
            : AccountView(),


      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem( icon: Icon(Icons.home),  label: 'Home'),
          BottomNavigationBarItem( icon: Icon(Icons.near_me), label: 'Near By'),
          BottomNavigationBarItem( icon: Icon(Icons.card_giftcard), label: 'Cart'),
          BottomNavigationBarItem( icon: Icon(FontAwesomeIcons.user), label: 'Account'),
        ],
        currentIndex: _index,
        selectedItemColor: Color(0xFFfd5352),
        onTap: (index) => setState(() => _index = index)
      ),


    );
  }
}
