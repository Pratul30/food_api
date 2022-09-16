import 'dart:convert';

import 'package:flutter_app/app/constants.dart';
import 'package:flutter_app/app/helper.dart';
import 'package:http/http.dart' as http;

class PaymentApi {

  static Future<dynamic> paymentCard(dynamic data) async {
    var response = await http.post(
      Uri.parse("${AppConstant.backendApi}/payments/card"),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${await AppHelper.getToken()}'

      },
      body: jsonEncode(data),
    );
    return AppHelper.response(response.body, response.statusCode);
  }


  static Future<dynamic> paymentListByCountry(String currency) async {
    var response = await http.get(
      Uri.parse("${AppConstant.backendApi}/payments/listPaymentByCountry?currency=$currency"),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Cookie': await AppHelper.getCookie(),
        'Authorization': 'Bearer ${await AppHelper.getToken()}'
      },
    );
    return AppHelper.response(response.body, response.statusCode);
  }




}
