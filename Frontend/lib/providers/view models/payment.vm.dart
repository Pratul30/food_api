import 'package:flutter/material.dart';
import 'package:flutter_app/api/payment.api.dart';



class PaymentVM with ChangeNotifier {


  bool _loading = false;
  String _error = "";
  int _status = 100;
  dynamic _paymentMethod = [];
  

  bool get isLoading => _loading;
  String get error => _error;
  int get status => _status;
  List<dynamic> get paymentMethod => _paymentMethod;



  setState(bool value, String err, int sttus, {dynamic paymentMethodd}){
    _loading = value;
    _error = err;
    _status = sttus;
    _paymentMethod = paymentMethodd;
    notifyListeners();
  }

  paymentCard(dynamic data) async {
    setState(true, "", 100);
    try {
      var resp = await PaymentApi.paymentCard(data);
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


  paymentListByCountry(String currency) async {
    setState(true, "", 100);
    try {
      var resp = await PaymentApi.paymentListByCountry(currency);
      if (resp[2] >= 200 && resp[2] <= 299) {
        setState(false, "", 200, paymentMethodd: resp[0]['data']);
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
