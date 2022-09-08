import 'package:flutter/material.dart';
import 'package:flutter_app/providers/view%20models/restaurant.dart';
import 'package:provider/provider.dart';

class BestFoodWidget extends StatefulWidget {
  @override
  _BestFoodWidgetState createState() => _BestFoodWidgetState();
}

class _BestFoodWidgetState extends State<BestFoodWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      width: double.infinity,
      child: Column(
        children: <Widget>[
          BestFoodTitle(),
          Expanded(
            child: BestFoodList(),
          )
        ],
      ),
    );
  }
}

class BestFoodTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var res = Provider.of<RestaurantVM>(context);
    var restaurants = res.getRestaurant;

    return Padding(
      padding: const EdgeInsets.only(left: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Top Nearby restaurants',
            style: TextStyle(fontSize: 20),
          ),
          FlatButton(
              onPressed: () {
                Navigator.of(context).pushNamed('Restaurant_list', arguments: {
                  'cuisine': 'All',
                  'list': restaurants,
                });
              },
              child: Text('Explore All'),
              textColor: Colors.orange)
        ],
      ),
    );
  }
}

class BestFoodTiles extends StatelessWidget {
  final String name;
  final id;
  final String info;
  final String imageUrl;
  final rating;

  BestFoodTiles({
    Key key,
    this.name,
    this.imageUrl,
    this.rating,
    this.info,
    this.id,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final image = imageUrl.replaceFirst('{width}', '1000');
    final imageSrc = image.replaceFirst('{height}', '1000');

    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed('/menu', arguments: {'id': id});
        //Provider.of<RestaurantVM>(context, listen: false).printres();
      },
      child: Container(
        height: 200,
        margin: EdgeInsets.all(10),
        child: Card(
          semanticContainer: true,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: Stack(
            children: [
              Image.network(
                imageSrc,
                fit: BoxFit.cover,
                width: double.infinity,
              ),
              Positioned(
                right: 0,
                bottom: 10,
                child: Container(
                  height: 50,
                  width: 250,
                  padding: EdgeInsets.only(top: 10, left: 10),
                  color: Colors.black54,
                  child: Text(
                    name.substring(3),
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        overflow: TextOverflow.ellipsis),
                  ),
                ),
              ),
            ],
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          elevation: 1,
          margin: EdgeInsets.all(5),
        ),
      ),
    );
  }
}

class BestFoodList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var res = Provider.of<RestaurantVM>(context);
    var restaurants = res.getRestaurant;

    return ListView.builder(
      itemBuilder: (context, index) => BestFoodTiles(
        name: restaurants[index].name,
        id: restaurants[index].id,
        imageUrl: restaurants[index].imageUrl,
        info: restaurants[index].info,
        rating: restaurants[index].rating,
      ),
      itemCount: 5,
    );
  }
}
