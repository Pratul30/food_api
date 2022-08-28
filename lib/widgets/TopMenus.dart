import 'package:flutter/material.dart';
import 'package:flutter_app/providers/menu.dart';
import 'package:provider/provider.dart';

class TopMenus extends StatefulWidget {
  @override
  _TopMenusState createState() => _TopMenusState();
}

class _TopMenusState extends State<TopMenus> {
  @override
  Widget build(BuildContext context) {
    return Consumer<MenuVM>(
      builder: (context, value, _) {
        return Container(
          height: 100,
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
      }
    );
  }
}

class TopMenuTiles extends StatelessWidget {
  String name;
  String imageUrl;

  TopMenuTiles(
      {Key? key,
      required this.name,
      required this.imageUrl
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed('Restaurant_list');
      },
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 10, right: 5, top: 5, bottom: 5),
            decoration: new BoxDecoration(
              boxShadow: [
                new BoxShadow(
                  color: Color(0xFFfae3e2),
                  blurRadius: 25.0,
                  offset: Offset(0.0, 0.75),
                ),
              ],
            ),
            child: Card(
              color: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: const BorderRadius.all(
                  Radius.circular(3.0),
                ),
              ),
              child: Container(
                width: 50,
                height: 50,
                child: Center(
                  child: Image.network(
                    imageUrl,
                    width: 24,
                    height: 24,
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
