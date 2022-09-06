import 'dart:convert';

import 'package:flutter_app/app/constants.dart';
import 'package:flutter_app/app/helper.dart';
import 'package:http/http.dart' as http;

class RestaurantApi {
  static Future<dynamic> getAllRestaurants(geoId) async {
    var response = await http.post(
      Uri.parse(AppConstant.listRestaurantsApi),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'X-RapidAPI-Key': AppConstant.rapidKey,
        'X-RapidAPI-Host': AppConstant.rapidHost
      },
      body: jsonEncode(
        <String, dynamic>{
          "geoId": geoId,
          "sort": "POPULARITY",
          "sortOrder": "desc",
        },
      ),
    );
    // .timeout(Duration(seconds: 2));
    return AppHelper.response(response.body, response.statusCode);
  }
}
