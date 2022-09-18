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

class Homely extends StatelessWidget {
  const Homely({ Key key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(left: 30.0),
          child: Center(
            child: Row(
              children: [
                Image.asset('assets/images/icon.png', height: 200.0, width: 200.0, fit: BoxFit.cover,),
                Text("Home",
                  style: TextStyle(
                    fontSize: 150.0,
                    color: Colors.orange,
                    fontWeight: FontWeight.bold
                  ),
                ),
                Text("ly",
                  style: TextStyle(
                    fontSize: 150.0,
                    color: Colors.purple,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
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
