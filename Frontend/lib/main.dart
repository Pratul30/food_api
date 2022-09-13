import 'package:flutter/material.dart';
import 'package:flutter_app/providers/auth.dart';
import 'package:flutter_app/providers/menu.dart';
import 'package:flutter_app/screens/Restaurant_list.dart';
import 'package:flutter_app/screens/auth/ForgotPasswordScreen.dart';
import 'package:flutter_app/screens/auth/SigninScreen.dart';
import 'package:flutter_app/screens/auth/SignupScreen.dart';
import 'package:flutter_app/screens/menu_list.dart';
import 'package:flutter_app/widgets/BottomNavBarWidget.dart';
import 'package:flutter_app/widgets/splashScreen.dart';
import 'package:provider/provider.dart';
import './providers/view models/menu_list.dart';
import './providers/view models/cart.dart';

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
        ChangeNotifierProvider(create: ((context) => MenuVM())),
        ChangeNotifierProvider(create: ((context) => AuthVM())),
        ChangeNotifierProvider(create: ((context) => MenuListVM())),
        ChangeNotifierProvider(create: ((context) => CartVM())),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: 'Roboto',
          primaryColor: Colors.orange,
        ),
        home: SplashScreen(),
        routes: {
          'home': (context) => BottomNavBarWidget(),
          'Restaurant_list': (context) => RestaurantListScreen(),
          'signin': (context) => SigninScreen(),
          'signup': (context) => SignupScreen(),
          'forgot_pwd': (context) => ForgotPasswordScreen(),
        },
        onGenerateRoute: (settings) {
          if (settings.name == '/menu') {
            final value = settings.arguments; // Retrieve the value.
            return MaterialPageRoute(
                builder: (_) => MenuListScreen(value)); // Pass it to BarPage.
          }
          return null; // Let `onUnknownRoute` handle this behavior.
        },
      ),
    );
  }
}
