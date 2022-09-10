import 'dart:convert';

import 'package:flutter_app/app/constants.dart';
import 'package:flutter_app/app/helper.dart';
import 'package:http/http.dart' as http;

class MenuApi {
  static Future<dynamic> getMenus(String id) async {
    var response = await http.post(
      Uri.parse(AppConstant.travelRestoApi),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'X-RapidAPI-Key': AppConstant.rapidKey,
        'X-RapidAPI-Host': AppConstant.rapidHost
      },
      body: jsonEncode(<String, dynamic>{
        "contentId": "$id",
        "reservationTime": "2022-03-07T20:00",
        "partySize": 2
      }),
    );
    // .timeout(Duration(seconds: 2));
    return AppHelper.response(response.body, response.statusCode);
  }
}
