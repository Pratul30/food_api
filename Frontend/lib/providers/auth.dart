import 'package:flutter/material.dart';
import 'package:flutter_app/api/auth.api.dart';



class AuthVM with ChangeNotifier {


  bool _loading = false;
  String _error = "";
  int _status = 100;
  

  bool get isLoading => _loading;
  String get error => _error;
  int get status => _status;


  setState(bool value, String err, int sttus){
    _loading = value;
    _error = err;
    _status = sttus;
    notifyListeners();
  }

  signin(dynamic data) async {
    setState(true, "", 100);
    try {
      var resp = await AuthApi.signin(data);
      print(resp);
      if (resp[2] >= 200 && resp[2] <= 299) {
        setState(false, "", 200);
      } else {
        setState(false, resp[1].toString(), resp[2]);
      }
    } on Exception catch (e) {
      debugPrint('[ON EXCEPTION CATCH]\n$e');
      setState(false, e.toString(), 500);
    } on Error catch (e) {
      debugPrint('[ON ERROR CATCH]\n$e');
      setState(false, e.toString(), 500);
    }
  }



  signup(dynamic data) async {
    setState(true, "", 100);
    try {
      var resp = await AuthApi.signup(data);
      if (resp[2] >= 200 && resp[2] <= 299) {
        setState(false, "", 200);
      } else {
        print(resp[1]['message']);
        setState(false, resp[1]['message'].toString(), resp[2]);
      }
    } on Exception catch (e) {
      debugPrint('[ON EXCEPTION CATCH]\n$e');
      setState(false, "someting when wrong", 500);
    } on Error catch (e) {
      debugPrint('[ON ERROR CATCH]\n$e');
      setState(false, e.toString(), 500);
    }
  }



  forgotPassword(dynamic data) async {
    setState(true, "", 100);
    try {
      var resp = await AuthApi.forgotPassword(data);
      if (resp[2] >= 200 && resp[2] <= 299) {
        setState(false, "", 200);
      } else {
        setState(false, resp[1].toString(), resp[2]);
      }
    } on Exception catch (e) {
      debugPrint('[ON EXCEPTION CATCH]\n$e');
      setState(false, e.toString(), 500);
    } on Error catch (e) {
      debugPrint('[ON ERROR CATCH]\n$e');
      setState(false, e.toString(), 500);
    }
  }


}
