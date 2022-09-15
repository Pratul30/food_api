import 'package:flutter/material.dart';
import 'package:flutter_app/api/auth.api.dart';
import 'package:flutter_app/app/helper.dart';
import 'package:flutter_app/providers/models/user.dart';
import 'package:jwt_decoder/jwt_decoder.dart';



class AuthVM with ChangeNotifier {


  bool _loading = false;
  String _error = "";
  int _status = 100;
  UserModel _user;
  

  bool get isLoading => _loading;
  String get error => _error;
  UserModel get user => _user;
  int get status => _status;


  setState(bool value, String err, int sttus){
    _loading = value;
    _error = err;
    _status = sttus;
    notifyListeners();
  }

  setUserModel(UserModel user){
    _user = user;
    notifyListeners();
  }

  getUser(dynamic data, String token){
    UserModel user = UserModel(
      firstName: data['first_name'],
      lastName: data['last_name'],
      email: data['email'],
      country: data['country'],
      cusId: data['cus_id'],
      ewalletId: data['ewallet_id'],
      businessVatId: data['business_vat_id'],
      token: token
    );
    AppHelper.setToken(token);
    setUserModel(user);
  }

  signin(dynamic data) async {
    setState(true, "", 100);
    /// clear all local storages
    AppHelper.clearLocalStates();
    try {
      var resp = await AuthApi.signin(data);
      if (resp[2] >= 200 && resp[2] <= 299) {
        setState(false, "", 200);
        getUser(resp[0]['data']['user'], resp[0]['data']['accessToken']);
      } else {
        setState(false, resp[1]['message'].toString(), resp[2]);
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
        setState(false, resp[1]['message'].toString(), resp[2]);
      }
    } on Exception catch (e) {
      debugPrint('[ON EXCEPTION CATCH]\n$e');
      setState(false, e.toString(), 500);
    } on Error catch (e) {
      debugPrint('[ON ERROR CATCH]\n$e');
      setState(false, e.toString(), 500);
    }
  }


  logout() async {
    setState(true, "", 100);
    try {
      var resp = await AuthApi.logout();
      if (resp[2] >= 200 && resp[2] <= 299) {
        setState(false, "", 200);
        AppHelper.clearLocalStates();
      } else {
        setState(false, resp[1]['message'].toString(), resp[2]);
      }
    } on Exception catch (e) {
      debugPrint('[ON EXCEPTION CATCH]\n$e');
      setState(false, e.toString(), 500);
    } on Error catch (e) {
      debugPrint('[ON ERROR CATCH]\n$e');
      setState(false, e.toString(), 500);
    }
  }


  refresh() async {
    setState(true, "", 100);
    try {
      var resp = await AuthApi.refresh();
    print(resp);
      if (resp[2] >= 200 && resp[2] <= 299) {
        setState(false, "", 200);
        var user = await JwtDecoder.decode(resp[0]['accessToken']);
        getUser(user['userData'], resp[0]['accessToken']);
      } else {
        setState(false, resp[1]['message'].toString(), resp[2]);
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
