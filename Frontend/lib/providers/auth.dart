import 'package:flutter/material.dart';
import 'package:flutter_app/api/auth.api.dart';
import 'package:flutter_app/app/helper.dart';
import 'package:flutter_app/providers/models/user.dart';



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

  signin(dynamic data) async {
    setState(true, "", 100);
    /// clear all local storages
    AppHelper.clearLocalStates();
    try {
      var resp = await AuthApi.signin(data);
      if (resp[2] >= 200 && resp[2] <= 299) {
        setState(false, "", 200);
        final value = resp[0]['data']['user'];
        UserModel user = UserModel(
          firstName: value['first_name'],
          lastName: value['last_name'],
          email: value['email'],
          country: value['country'],
          cusId: value['cus_id'],
          ewalletId: value['ewallet_id'],
          businessVatId: value['business_vat_id'],
          token: resp[0]['data']['accessToken']
        );
        AppHelper.setToken(user.token);
        setUserModel(user);
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


}
