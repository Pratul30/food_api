import 'package:flutter/material.dart';
import 'package:flutter_app/providers/location.dart';
import 'package:provider/provider.dart';

import '../providers/view models/geoId.dart';

class RestaurantCard extends StatelessWidget {
  RestaurantCard(this.id, this.name, this.info, this.imageUrl, this.rating,
      this.totalreviews);

  final String name;
  final id;
  final String info;
  final String imageUrl;
  final rating;
  final totalreviews;

  @override
  Widget build(BuildContext context) {
    final image = imageUrl.replaceFirst('{width}', '1000');
    final imageSrc = image.replaceFirst('{height}', '1000');
    final String affordability = info.substring(0, info.indexOf('â') - 1);
    final String cuisines =
        info.substring(info.indexOf('¢') + 2).replaceAll('â¢', '•');

    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed('/menu', arguments: {
          'id': id,
        });
      },
      child: Container(
        height: 250,
        margin: EdgeInsets.only(
          top: 20,
          left: 10,
          right: 10,
        ),
        width: double.infinity,
        child: Card(
          clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            children: [
              Expanded(
                flex: 8,
                child: Image.network(
                  imageSrc,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Expanded(
                flex: 3,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 5,
                        child: Container(
                          padding: const EdgeInsets.only(right: 10.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                name.substring(3),
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    overflow: TextOverflow.ellipsis),
                              ),
                              Text(
                                cuisines,
                                style:
                                    TextStyle(overflow: TextOverflow.ellipsis),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Container(
                          margin: EdgeInsets.all(10),
                          child: Text(
                            affordability,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '$rating',
                              style: TextStyle(fontSize: 18),
                            ),
                            Icon(
                              Icons.star,
                              color: Colors.yellow[700],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          elevation: 5,
        ),
      ),
    );
  }
}
