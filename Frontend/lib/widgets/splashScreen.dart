import 'package:flutter/material.dart';
import 'package:flutter_app/app/helper.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({ Key key }) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {


  @override
  void initState() {
    super.initState();
    refresh();
  }

  void refresh() async {
    final String token = await AppHelper.getToken();
    print('token: $token');
    if(token != null && token != "")
      Navigator.pushNamedAndRemoveUntil(context, 'home', (route) => false);
    else
      Navigator.pushNamedAndRemoveUntil(context, 'signin', (route) => false);

  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image.asset(
          'assets/images/menus/ic_food_express.png', 
          width: MediaQuery.of(context).size.width/1.5,
          fit: BoxFit.contain
        ),
      ),
    );
  }
}