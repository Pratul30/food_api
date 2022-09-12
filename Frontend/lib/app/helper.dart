
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';


class AppHelper {
  
  static List<dynamic> response(data, int status){
    if(isJsonParsable(data)){
      if(status >= 200 && status <=299){
        return [jsonDecode(data), "", status];
      }else {
        if(status == 408){
          return ["", "internet error", 408];
        }
        if(jsonDecode(data) != null) {
          return ["", jsonDecode(data), status];
        }
        return ['', 'something went wrong', status];
      }
    } 
    return ['', 'something went wrong', 500];
  }


  static isJsonParsable (string) {
    try {
        jsonDecode(string);
    } catch (e) {
        return false;
    }
    return true;
  }


  static setToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('token', token).then((_) {
        print('token saved success');
    }).catchError((err){
      print('error to set token: $err');
    });
  }

  static getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String token = prefs.getString('token');
    return token;
  }



  static Future<String> getCookie() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String cookie = prefs.getString('cookie');
    return cookie;
  }

  static clearLocalStates() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.clear();
  }


  static void setCookie(var response) async {
    String rawCookie = response.headers['set-cookie'];
    if (rawCookie != null) {
      int index = rawCookie.indexOf(';');
      var cookie = (index == -1) ? rawCookie : rawCookie.substring(0, index);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('cookie', cookie).then((_) {
          print('cookie saved success');
      }).catchError((err){
          print('error to set cookie: $err');
      });
    }
  }

}