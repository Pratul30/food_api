import 'package:scanner/Utils/constants.dart';
import 'package:scanner/Utils/helpers.dart';
import 'package:scanner/Utils/widgets.dart';
import 'package:scanner/http/http_auth.dart';
import 'package:scanner/http/http_carnet.dart';
import 'package:scanner/models/model_carnet.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';


class UtilsModel {
  String status; 

  /// disable or enable button
  bool showBtn;
  UtilsModel({this.status, this.showBtn });
}



class CarnetController extends GetxController {

  var isLoading = true.obs;
  var codeStatus = 0.obs;
  var error = "";
  var userToken = "".obs;
  MyWidgets my = MyWidgets();
  final GlobalKey<State> _keyLoader = GlobalKey<State>();
  RxList<CarnetModel> cm = <CarnetModel>[].obs;





  final utModel = UtilsModel(status: "on", showBtn: false).obs;

   updateToken(var v){
    userToken.value = v;
    update();
  }
  
  updateUtils({var status, bool showBtn}){
    utModel.update((val) {
      if(status != null) val.status= status;
 val.showBtn= showBtn;
    });
  }




  Future<String> signin(ctx, String email, String pwd) async {
      error = "";
      try {
        isLoading(true);
        my.showLoading(ctx, _keyLoader);
        var user = await HttpASignin.signin(email, pwd);
        if(user[0] != ""){
          userToken.value = user[0];
          Helpers.setToken(user[0]);
        }
        else {
          error = user[1];
        }

      }on Error catch (e) {
        var err = ["","Une erreur de connexion c'est produit !!!"];
        error = err[1];
        print("error: $e");
      }
      finally {
        // this.isLoading = false;
        isLoading(false);
        Navigator.of(_keyLoader.currentContext,rootNavigator: true).pop();
      }
      return error;
  }



  Future<List> controleCarnet(ctx, String id) async {
      List data;
      try {
        isLoading(true);
        data = await HttpCarnet.controleCarnet(id);
      }on Error {}
      finally {
        isLoading(false);
        Get.back();
        print("code::: ${data[1][0]} ");
        if(data != null){
          if(data[1][0] == 409){
            codeStatus.value = 409;
            my.scanResult(
              ctx,409,
              () async { 
                 Get.back(); //close dialog 
                 Get.back(); // back to last screen 
              }, 
            );
          } else if(data[1][0] == 200){
             codeStatus.value = 200;
             my.scanResult(
              ctx,200,
              () async { 
                Get.back();
                Get.back();
              }, 
            );
          } else {
            Helpers.toast("Une erreur inconnue s'est produite !",time:5);
          }
        } else {
          Helpers.toast("Une erreur du serveur s'est produite !",time:5);
        }
      }
  }

}