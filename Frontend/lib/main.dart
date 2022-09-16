import 'package:flutter/material.dart';
import 'package:flutter_app/providers/view%20models/auth.vm.dart';
import 'package:flutter_app/providers/menu.dart';
import 'package:flutter_app/providers/view%20models/payment.vm.dart';
import 'package:flutter_app/screens/Restaurant_list.dart';
import 'package:flutter_app/screens/auth/ForgotPasswordScreen.dart';
import 'package:flutter_app/screens/auth/SigninScreen.dart';
import 'package:flutter_app/screens/auth/SignupScreen.dart';
import 'package:flutter_app/screens/menu_list.dart';
import 'package:flutter_app/widgets/BottomNavBarWidget.dart';
import 'package:flutter_app/widgets/splashScreen.dart';
import 'package:provider/provider.dart';
import 'providers/view models/menu_list.vm.dart';
import 'providers/view models/cart.vm.dart';

import 'providers/view models/restaurant.vm.dart';
import './screens/CartScreen.dart';

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
        ChangeNotifierProvider(create: ((context) => PaymentVM())),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: 'Roboto',
          primarySwatch: Colors.purple,
        ),
        home: SplashScreen(),
        routes: {
          'home': (context) => BottomNavBarWidget(),
          'Restaurant_list': (context) => RestaurantListScreen(),
          'signin': (context) => SigninScreen(),
          'signup': (context) => SignupScreen(),
          'forgot_pwd': (context) => ForgotPasswordScreen(),
          'cart_screen': (context) => CartScreen(),
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
