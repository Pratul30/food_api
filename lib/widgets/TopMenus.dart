import 'package:flutter/material.dart';
import 'package:flutter_app/providers/menu.dart';
import 'package:flutter_app/providers/view%20models/restaurant.dart';
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
      height: 200,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              left: 10,
              top: 10,
              bottom: 5,
            ),
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
                      fontSize: 25, letterSpacing: 3, color: Colors.orange),
                )
              ],
            ),
          ),
          Consumer<MenuVM>(builder: (context, value, _) {
            return Container(
              height: 125,
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
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
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
                width: 70,
                height: 70,
                child: Center(
                  child: Image.asset(
                    imageUrl,
                    width: 50,
                    height: 50,
                  ),
                ),
              ),
            ),
          ),
          Text(name,
              style: TextStyle(
                  color: Color(0xFF6e6e71),
                  fontSize: 14,
                  fontWeight: FontWeight.w400)),
        ],
      ),
    );
  }
}
