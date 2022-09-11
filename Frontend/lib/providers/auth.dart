import 'package:flutter/cupertino.dart';
import 'package:flutter_app/api/auth.api.dart';



class AuthVM extends ChangeNotifier {


  bool isLoading = false;
  String error = "";

  signin(dynamic data) async {
    print('loading....');
    isLoading = true;
    try {
      var resp = await AuthApi.signin(data);
      if (resp[2] >= 200 || data[2] <= 299) {

      } else {
        error = data[1];
      }
    } on Exception catch (e) {
      debugPrint('[ON EXCEPTION CATCH]\n$e');
      error = e.toString();
    } on Error catch (e) {
      debugPrint('[ON ERROR CATCH]\n$e');
      error = e.toString();
    } finally {
      isLoading = false;
      print('fianlly...');
    }
    notifyListeners();
  }



  signup(dynamic data) async {
    print('loading....');
    isLoading = true;
    try {
      var resp = await AuthApi.signup(data);
      if (resp[2] >= 200 || data[2] <= 299) {

      } else {
        error = data[1];
      }
    } on Exception catch (e) {
      debugPrint('[ON EXCEPTION CATCH]\n$e');
      error = e.toString();
    } on Error catch (e) {
      debugPrint('[ON ERROR CATCH]\n$e');
      error = e.toString();
    } finally {
      isLoading = false;
      print('fianlly...');
    }
    notifyListeners();
  }



  forgotPassword(dynamic data) async {
    print('loading....');
    isLoading = true;
    try {
      var resp = await AuthApi.forgotPassword(data);
      if (resp[2] >= 200 || data[2] <= 299) {

      } else {
        error = data[1];
      }
    } on Exception catch (e) {
      debugPrint('[ON EXCEPTION CATCH]\n$e');
      error = e.toString();
    } on Error catch (e) {
      debugPrint('[ON ERROR CATCH]\n$e');
      error = e.toString();
    } finally {
      isLoading = false;
      print('fianlly...');
    }
    notifyListeners();
  }


}
