import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/providers/view%20models/restaurant.vm.dart';
import 'package:provider/provider.dart';

import 'package:flutter_app/widgets/BestFoodWidget.dart';
import 'package:flutter_app/widgets/SearchWidget.dart';
import 'package:flutter_app/widgets/TopMenus.dart';

import '../widgets/loading.widget.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final res = Provider.of<RestaurantVM>(context);
    final appBar = AppBar(
      backgroundColor: Color(0xFFFAFAFA),
      elevation: 0,
      title: Text(
        "What would you like to eat?",
        style: TextStyle(
            color: Color(0xFF3a3737),
            fontSize: 16,
            fontWeight: FontWeight.w500),
      ),
      actions: <Widget>[
        IconButton(
          icon: Icon(
            Icons.notifications_none,
            color: Color(0xFF3a3737),
          ),
          onPressed: () {},
        )
      ],
      systemOverlayStyle: SystemUiOverlayStyle.dark,
    );
    return Scaffold(
      appBar: appBar,
      body: res.loadingRestaurantList
          ? Center(
              child: LoadingWidget(),
            )
          : SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  SearchWidget(),
                  TopMenus(),
                  SizedBox(
                    height: 10,
                  ),
                  //PopularFoodsWidget(),
                  BestFoodWidget(),
                ],
              ),
            ),
    );
  }
}
