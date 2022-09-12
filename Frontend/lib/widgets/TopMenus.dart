import 'package:flutter/material.dart';
import 'package:flutter_app/providers/menu.dart';
import 'package:flutter_app/providers/view%20models/restaurant.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import '../providers/models/restaurant.dart';

class TopMenus extends StatefulWidget {
  @override
  _TopMenusState createState() => _TopMenusState();
}

class _TopMenusState extends State<TopMenus> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 175,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            // decoration: BoxDecoration(boxShadow: [
            //   BoxShadow(
            //       color: Color.fromARGB(255, 255, 239, 211),
            //       blurRadius: 10,
            //       blurStyle: BlurStyle.normal),
            // ]),
            padding: const EdgeInsets.only(left: 10, top: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Restaurants By',
                  style: TextStyle(
                    fontSize: 20,
                    letterSpacing: 2,
                  ),
                ),
                Text(
                  'Cuisines...',
                  style: TextStyle(
                      fontSize: 25,
                      letterSpacing: 3,
                      color: Colors.orange,
                      fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Consumer<MenuVM>(builder: (context, value, _) {
            return Expanded(
              child: Container(
                decoration: BoxDecoration(boxShadow: [
                  BoxShadow(
                      color: Color.fromARGB(255, 255, 245, 228),
                      blurRadius: 5,
                      blurStyle: BlurStyle.normal),
                ]),
                // height: 110,
                child: ListView.builder(
                  itemCount: value.menu.length,
                  itemBuilder: (BuildContext context, int index) {
                    return TopMenuTiles(
                      name: value.menu[index].name,
                      imageUrl: value.menu[index].imageUrl,
                    );
                  },
                  scrollDirection: Axis.horizontal,
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}

class TopMenuTiles extends StatelessWidget {
  final String name;
  final String imageUrl;

  TopMenuTiles({
    Key key,
    @required this.name,
    @required this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final res = Provider.of<RestaurantVM>(context, listen: false);

    return InkWell(
      onTap: () {
        List<Restaurant> filterList = res.filterRestaurantsByCuisine(name);
        Navigator.of(context).pushNamed('Restaurant_list', arguments: {
          'cuisine': name,
          'list': filterList,
        });
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(
              left: 10,
              right: 10,
            ),
            decoration: new BoxDecoration(
                // boxShadow: [
                //   new BoxShadow(
                //     color: Colors.orange[100],
                //     blurRadius: 25.0,
                //     offset: Offset(0.0, 0.75),
                //   ),
                // ],
                ),
            child: Card(
              color: Colors.white,
              elevation: 5,
              // shape: RoundedRectangleBorder(
              //   borderRadius: const BorderRadius.all(

              //   ),
              // ),
              child: Container(
                width: 50,
                height: 50,
                child: Center(
                  child: Image.asset(
                    imageUrl,
                    width: 30,
                    height: 30,
                  ),
                ),
              ),
            ),
          ),
          Text(name,
              style: TextStyle(
                  //color: Colors.deepPurple,
                  fontSize: 14,
                  fontWeight: FontWeight.w400)),
        ],
      ),
    );
  }
}
