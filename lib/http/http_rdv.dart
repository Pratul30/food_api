
import 'package:http/http.dart' as http;
import 'package:scanner/models/model_error.dart';
import 'dart:convert';

class HttpRDV {


  static Map <String, String> headers = {
    'Content-Type': 'application/json',
  };


static Future<List> rdvForm({nom,codeP, phone1, phone2, email, codeDHIS2, pointD,dateRDV, isVaccine}) 
  async {
    var response = await http.post(
        Uri.parse(""),
        headers: headers,
        body:jsonEncode(<String, String>{ }
        ),
      ).timeout(const Duration(seconds: 30));

    if (response.statusCode == 200) {
      var json = response.body;
      var data = jsonDecode(json);
      print("code 200::: success");
      if (data != false) {
        return [json, ""];
      } else {
        return ["", "Une erreur à été rencontré !!!"];
      }
    } else {
      var json = response.body;
      ErrorModel().fromJson(json.decode(json));
      print("error else:: $json ${response.statusCode} ");
      if (ErrorModel().error == null) {
        return ["", "Une erreur inconnue"];
      } else {
        return ["", ErrorModel().error];
      }
    }
  }

}
