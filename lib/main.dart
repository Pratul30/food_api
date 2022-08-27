import 'package:flutter/material.dart';
import 'package:flutter_app/screens/Restaurant_list.dart';
import 'package:provider/provider.dart';

import '../providers/restaurant.dart';
import '../screens/HomeScreen.dart';
import '../providers/location.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: ((context) => RestaurantVM()),
        ),
        ChangeNotifierProvider(
          create: ((context) => Location()),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(fontFamily: 'Roboto', hintColor: Color(0xFFd0cece)),
        home: HomeScreen(),
        routes: {
          'Restaurant_list': (context) => RestaurantListScreen(),
        },
      ),
    );
  }
}
