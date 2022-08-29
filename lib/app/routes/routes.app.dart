
import 'package:flutter/material.dart';
import 'package:flutter_app/view/home.view.dart';

  class RoutesApp {
    static const String homeview = '/home';
  }


  /// routes map list 
  Map<String, Widget Function(BuildContext)> routesMap = {
    RoutesApp.homeview: (context) => HomeView(),
  };