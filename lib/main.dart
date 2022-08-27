import 'package:flutter/material.dart';
import 'package:flutter_app/screens/HomeScreen.dart';
import 'package:flutter_app/screens/Restaurant_list.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Roboto', hintColor: Color(0xFFd0cece)),
      home: HomeScreen(),
      routes: {
        'restaurant_list': (context) => RestaurantListScreen(),
      },
    );
  }
}
