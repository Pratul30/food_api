import 'package:scanner/Utils/constants.dart';
import 'package:scanner/controller/carnet_controller.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


final carnetCtrl = Get.find<CarnetController>();
class HttpCarnet {



 static Future<List> controleCarnet(String id) async {
   print(":::::::::::::::::::::id carnet: $id");
    var response = await http.post(
      Uri.parse("${MyCst.URL}/controle"),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${carnetCtrl.userToken.value}'
      },
      body:jsonEncode(<String, String>{"id_carnet": id}),
    ).timeout(
      const Duration(seconds: 30),
      onTimeout: () {
        return null;
      },
    );


    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      return [json['success'], [response.statusCode, ""]];
    } else {
      print('json:: ${response.body} ');
      var err = jsonDecode(response.body);
      if (err['erreur'] == null) {
        return ["", "Unknown Error"];
      } else {
        return ["", [response.statusCode,err['erreur']]];
      }
    }
  }

}
