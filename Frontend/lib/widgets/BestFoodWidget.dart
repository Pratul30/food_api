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
      height: MediaQuery.of(context).size.height -
          MediaQuery.of(context).padding.top -
          300,
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

    return Container(
      // decoration: BoxDecoration(boxShadow: [
      //   BoxShadow(
      //       color: Color.fromARGB(255, 255, 239, 211),
      //       blurRadius: 10,
      //       blurStyle: BlurStyle.normal),
      // ]),
      padding: const EdgeInsets.only(left: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Top Restaurants Nearby',
            style: TextStyle(fontSize: 20),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pushNamed('Restaurant_list', arguments: {
                'cuisine': 'All',
                'list': restaurants,
              });
            },
            child: Text(
              'Explore All',
              style: TextStyle(fontSize: 17, color: Colors.orange),
            ),
          )
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
    final String affordability = info.substring(0, info.indexOf('â') - 1);
    final String cuisines =
        info.substring(info.indexOf('¢') + 2).replaceAll('â¢', '•');

    return InkWell(
        onTap: () {
          Navigator.of(context).pushNamed('/menu', arguments: {'id': id});
          print(info);
          //Provider.of<RestaurantVM>(context, listen: false).printres();
        },
        child: Container(
          padding: EdgeInsets.all(10),
          height: 175,
          width: double.infinity,
          child: Row(
            // mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                flex: 4,
                child: Container(
                  height: double.infinity,
                  child: Card(
                    clipBehavior: Clip.antiAlias,
                    child: Image.network(
                      imageSrc,
                      fit: BoxFit.cover,
                    ),
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                  ),
                ),
              ),
              Expanded(
                  flex: 5,
                  child: Container(
                    height: double.infinity,
                    padding: EdgeInsets.only(
                      left: 10,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name.substring(3),
                          maxLines: 1,
                          style: TextStyle(
                              fontSize: 20,
                              color: Color.fromARGB(255, 213, 30, 245),
                              fontFamily: 'Times New Roman',
                              fontWeight: FontWeight.bold,
                              overflow: TextOverflow.ellipsis),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          cuisines,
                          style: TextStyle(
                            fontSize: 15,
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(affordability),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Text(
                              rating.toString(),
                              style: TextStyle(fontSize: 20),
                            ),
                            Icon(Icons.star, color: Colors.yellow[700]),
                          ],
                        )
                      ],
                    ),
                  ))
            ],
          ),
        ));
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
