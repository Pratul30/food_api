import 'package:flutter/material.dart';
import 'package:flutter_app/providers/menu.dart';
import 'package:flutter_app/screens/Restaurant_list.dart';
import 'package:flutter_app/screens/menu_list.dart';
import 'package:provider/provider.dart';

import 'providers/view models/geoId.dart';
import 'providers/location.dart';
import '../screens/HomeScreen.dart';

import './providers/view models/restaurant.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<RestaurantVM>(
          create: ((context) => RestaurantVM()),
        ),
        ChangeNotifierProvider(
          create: ((context) => MenuVM()),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(fontFamily: 'Roboto', hintColor: Color(0xFFd0cece)),
        home: HomeScreen(),
        routes: {
          'Restaurant_list': (context) => RestaurantListScreen(),
          'menu_list': (context) => MenuListScreen(),
        },
      ),
    );
  }
}
