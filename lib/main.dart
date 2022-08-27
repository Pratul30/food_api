import 'package:flutter/material.dart';
import 'package:rapyd_app/app/widgets/bottom.bar.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(fontFamily: 'Roboto', hintColor: Color(0xFFd0cece)),
        home: BottomBar(),
    );
  }
}
