import 'package:scanner/Utils/constants.dart';
import 'package:scanner/models/model_error.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class HttpASignin {


  static Future<List> signin(String email, String password) async {
    var response = await http.post(
      Uri.parse("${MyCst.URL}/LoginControle"),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body:jsonEncode(<String, String>{
          "email": email,
          "password":password, 
        }
      ),
    ).timeout(
      const Duration(seconds: 30),
      onTimeout: () {
        return null;
      },
    );


    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      return [json['access_token'], ""];
    } else {
      var err = jsonDecode(response.body);
      print("error: $err");
      if (err['erreur'] == null) {
        return ["", "Unknown Error"];
      } else {
        return ["", err['erreur']];
      }
    }
  }


}
