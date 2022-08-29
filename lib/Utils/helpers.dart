import 'package:controlecarnet/Utils/colors.dart';
import 'package:controlecarnet/Utils/constants.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';
import 'package:controlecarnet/Utils/widgets.dart';
import 'package:controlecarnet/controller/carnet_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:velocity_x/velocity_x.dart';
MyWidgets my = MyWidgets();


class Helpers {


  /// check if user has a connection 
  static checkConnection(context, callback()) async {
    final carnetCtrl = Get.find<CarnetController>();
    var result = await Connectivity().checkConnectivity();
    if (result == ConnectivityResult.none) {
      carnetCtrl.updateUtils(status: "off");
      // carnetCtrl.updateStatus("off");
      Helpers.snackBar(
        title: 'Infos', 
        msg: "vous n'êtes pas connecté !!!", 
        icon: Icon(Feather.info, color:Vx.white),
      );
    } else if (result == ConnectivityResult.mobile || result == ConnectivityResult.wifi) {
      carnetCtrl.updateUtils(status: "on");
      callback();
    } else {
      carnetCtrl.updateUtils(status: "off");
      // carnetCtrl.updateStatus("off");
       Helpers.snackBar(
        title: 'Infos', 
        msg: "vous n'êtes pas connecté !!!", 
        icon: Icon(Feather.info, color:Vx.white),
      );
    }
  }


  static setToken(token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(MyCst.userKey, token);
  }



  static snackBar({
    title:'Infos', msg:'', int time:3, bColor:Vx.black, Widget icon, 
    color:Vx.white, SnackPosition position: SnackPosition.BOTTOM, Widget widget
  }) {
    Get.showSnackbar(
      GetBar(
          title: title,
          duration: Duration(seconds: time),
          backgroundColor: bColor, 
          icon: icon, 
          snackPosition: position, 
          messageText: msg.toString().text.color(color).make(),
          mainButton: widget
      ),
    );
  }

  static toast(msg,{data: "", position:SnackPosition.BOTTOM, time:3, Widget widget}){
    if(data != ""){
      Helpers.snackBar(
        title: 'Success', 
        msg: msg, 
        position: position,
        time: time,
        bColor: MyColors.kLightGreen,
        icon: Icon(Feather.check_circle, color:Vx.white),
        widget: widget
      );
    } else {
        Helpers.snackBar(
        title: 'Erreur', 
        time: time,
        msg: msg, 
        position: position,
        bColor: Vx.red500,
        icon: Icon(Icons.close, color:Vx.white),
        widget: widget
      );
    }
  }





}