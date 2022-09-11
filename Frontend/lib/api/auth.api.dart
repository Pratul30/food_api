import 'dart:convert';

import 'package:flutter_app/app/constants.dart';
import 'package:flutter_app/app/helper.dart';
import 'package:http/http.dart' as http;

class AuthApi {

  static Future<dynamic> signin(dynamic data) async {
    var response = await http.post(
      Uri.parse("${AppConstant.backendApi}/user/login"),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(data),
    );
    return AppHelper.response(response.body, response.statusCode);
  }

  static Future<dynamic> signup(dynamic data) async {
    var response = await http.post(
      Uri.parse("${AppConstant.backendApi}/user/register"),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(data),
    );
    return AppHelper.response(response.body, response.statusCode);
  }


  static Future<dynamic> forgotPassword(dynamic data) async {
    var response = await http.post(
      Uri.parse("${AppConstant.backendApi}/forgot-pwd"),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(data),
    );
    return AppHelper.response(response.body, response.statusCode);
  }


  static Future<dynamic> profil() async {
    var response = await http.get(
      Uri.parse("${AppConstant.backendApi}/profil"),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'Bearer token'
      },
    );
    return AppHelper.response(response.body, response.statusCode);
  }

  static Future<dynamic> refresh() async {
    var response = await http.get(
      Uri.parse("${AppConstant.backendApi}/user/refresh"),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'Bearer token'
      },
    );
    return AppHelper.response(response.body, response.statusCode);
  }


}
