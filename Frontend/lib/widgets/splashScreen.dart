import 'package:flutter/material.dart';
import 'package:flutter_app/app/helper.dart';
import 'package:flutter_app/providers/auth.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:provider/provider.dart';

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
    if(token != null && token != ""){
      Navigator.pushNamedAndRemoveUntil(context, 'home', (route) => false);
      bool  isExpired = JwtDecoder.isExpired(token);
      var user = JwtDecoder.decode(token);
      print('isExpired: $isExpired');
      if(!isExpired){
        await Provider.of<AuthVM>(context, listen: false).refresh();
      } else
        await Provider.of<AuthVM>(context, listen: false).getUser(user['userData'], token);
    }
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