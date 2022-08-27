

import 'dart:io';
import 'package:rapyd_app/api/exception.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AppApi {

  Future getAPI({String? url, Map<String, String>? headers}) async {
    dynamic responseJson;
    try {
      final response = await http.get(
        Uri.parse(url!),
        headers: headers
      );
      responseJson = responseAPI(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;

  }


  Future postAPI({String? url , dynamic data, Map<String, String>? headers}) async{
    dynamic responseJson;
    try {
      final response = await http.post(
        Uri.parse(url!),
        body: data,
        headers: headers
      );
      responseJson = responseAPI(response);
    }on SocketException {
      throw FetchDataException('No Internet Connection');
    }
    return responseJson;
  }


  // Future deleteAPI(...) async {}
  // Future putAPI(...) async {}
  // Future patchAPI(...) async {}



  dynamic responseAPI (http.Response response){
    switch(response.statusCode){
      case 200:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson ;
      case 400:
        throw BadRequestException(response.body.toString());
      case 500:
      case 404:
        throw UnauthorisedException(response.body.toString());
      default:
        throw FetchDataException('Error accured while communicating with server'+
            'with status code' +response.statusCode.toString());
    }
  }



}