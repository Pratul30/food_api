import 'package:flutter/material.dart';
import 'package:flutter_animator/flutter_animator.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:controlecarnet/Utils/colors.dart';
import 'package:controlecarnet/Utils/constants.dart';
import 'package:lottie/lottie.dart';
import 'package:velocity_x/velocity_x.dart';


class MyWidgets {

  // colors


  // iconbutton
  IconButton iconBtn(icon, click){
    return IconButton(
      icon:icon,
      onPressed: click,
    );
  }



  

  Widget loadAgain(Function link, {String desc}){
    return Center(
      child:Stack(
        alignment: Alignment.topCenter,
        children: [
          Container(
            margin:EdgeInsets.all(100.0),
            padding:EdgeInsets.symmetric(vertical: 0.0),
            child: Lottie.asset("assets/cross.json", repeat: false),
          ),
          Positioned(
            bottom:40,
            child:text(desc == null 
            ? "${MyCst.ErrorConnexion}" 
            : desc, color:Colors.grey, fw:FontWeight.w400),
          ),

          Positioned(
            bottom:0,
            child: InkWell(
              onTap: link,
              child:Center(child: text("Réessayez", fw:FontWeight.bold, color:MyColors.kBlue),)
            )
          ),
        ],
      )
    );
  }




  Future<void> showLoading(BuildContext context, GlobalKey key) async {
    return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return new WillPopScope(
              onWillPop: () async => false,
              child: SimpleDialog(
                  elevation: 0.0,
                  key: key,
                  backgroundColor: Color.fromRGBO(38, 38, 38, 0.7),
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          child: CircularProgressIndicator(
                            strokeWidth: 3.5, 
                            valueColor: AlwaysStoppedAnimation<Color>(Vx.white)
                          ),
                          height: 30,
                          width: 30,
                        ),
                        10.heightBox,
                        text("chargement...", color:Vx.white, fw:FontWeight.w400)
                      ],
                    )
                  ]
              )
          );
        }
      );
  }

  Future<void> toast(context, msg, {bgColor:Vx.black, txtColor:Vx.white}){
    VxToast.show(
      context,
      msg: msg,
      bgColor: bgColor,
      textColor: txtColor,
      showTime: 5000
    );
  }


  Widget richText({t1,t2}){
    return RichText(
      text: TextSpan(
        text: '$t1',
        style: TextStyle(fontWeight: FontWeight.w500,fontSize: 15.0, color: Vx.black),
        children:[
          TextSpan(
            text: '$t2',
            style: TextStyle(fontWeight: FontWeight.w400, fontSize: 13.0, color: Vx.black)
          ),
        ],
      ),
    );
  }

  TextStyle textStyle({color:Colors.black,size:15.0,fw:FontWeight.bold,double space}){
    return TextStyle(
          color: color,
          fontWeight: fw,
          fontSize: size,
          letterSpacing: space,
          // fontFamily: 'Nunito'
        );
  }

  Widget text(String text,{color:Colors.black,center:TextAlign.center,size:15.0,fw:FontWeight.bold,double space, fontStyle: ''}){
    return Text(text, textAlign: center,
        style: fontStyle == 'fredokaOne'
         ? GoogleFonts.fredokaOne(textStyle: textStyle(color:color,fw:fw, size:size, space:space))
         : textStyle(color:color,fw:fw, size:size, space:space)
    );
  }


Widget inputUi({ctrl, label, fillColor:Colors.black12,
  Function onChange,height:40.0,mxl:1, fsHeight:0.0,String initValue, type: TextInputType.text}){
    return   TextFormField(
      controller: ctrl,
      keyboardType: type,
      initialValue: initValue,
      maxLines: mxl,
      style: TextStyle(
        height: fsHeight, 
      ),
      decoration: InputDecoration(
        hintText:label,
        hintStyle: TextStyle(
          fontSize: 12.0
        ),
        filled: true, 
        fillColor:fillColor, 
        focusedBorder: new UnderlineInputBorder(
          borderSide: new BorderSide(color:Colors.black)
        ),
      ),
      onChanged: (value){onChange(value);},
    ).box.height(height).make();
}



  Widget outlineUI(child,{
    bg:Colors.white24, radius:20.0, outlineColor:Colors.transparent,
    width:1.5, ht:20.0, vt:5.0,longBtn
    }){
    return Container(
      width: longBtn,
      decoration: BoxDecoration(
        color:bg,
        borderRadius: BorderRadius.all(Radius.circular(radius)),
        border:Border.all(color:outlineColor, width:width)
      ),
      padding:EdgeInsets.symmetric(horizontal: ht, vertical: vt),
      child:child
    );
  }


  Widget row(child1, child2,
  {space:2.0,cross:CrossAxisAlignment.start, main: MainAxisAlignment.start})
  {
    return Row(
      crossAxisAlignment:cross,
      mainAxisAlignment: main,
      children: [
        child1,
        SizedBox(width: space),
        child2
      ],
    );
  }


  Widget col(child1, child2,
  {space:0.0,cross:CrossAxisAlignment.start, main: MainAxisAlignment.start})
  {
    return Column(
      crossAxisAlignment:cross,
      mainAxisAlignment: main,
      children: [
        child1,
        SizedBox(height: space),
        child2,
      ],
    );
  }




BoxDecoration sheetcorner({Color color:Colors.white}){
  return BoxDecoration(
      color:color,
      borderRadius: BorderRadius.only(topLeft: Radius.circular(10.0), topRight: Radius.circular(10))
    );
}


  Future bottomSheet(BuildContext context,{ @required Widget child,
    bcolor:Vx.white,barColor:Vx.gray500, dismiss:true, radius:10.0}) async{
    return Get.bottomSheet(
      Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: Container(
          padding: EdgeInsets.only(bottom: 20), 
          decoration: sheetcorner(color:bcolor),
          child: child
        )
      ),
      isScrollControlled: true,
      isDismissible: dismiss,
    );
  }


  Widget divider({color:Colors.black26, thick:0.5}){
    return Divider(
      color: color,
      thickness: thick,
    );
  }




  Future<void> modal(BuildContext context,child, {bcolor:Vx.white}) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,

      builder: (BuildContext context){
        return SimpleDialog(
          backgroundColor: bcolor,
          children: <Widget>[
            Container(
              padding:EdgeInsets.all(10),
              child:child
            )
          ]
        );
      }, 

    );
  }






  Widget button({@required Widget child,@required onPressed, Color color: Colors.blue,Color overColor: Colors.black, double width:200.0, double height: 50.0}){
    return ElevatedButton(
      onPressed: onPressed,
      child: child,
      style: ButtonStyle(
        animationDuration: 200.milliseconds,
        enableFeedback: true,
        backgroundColor: MaterialStateProperty.all(color),
        elevation: MaterialStateProperty.all(10.0),
        minimumSize: MaterialStateProperty.all(Size(width,height)),
        overlayColor: MaterialStateProperty.all(overColor.withOpacity(0.3)),
        shadowColor: MaterialStateProperty.all(color),
        visualDensity: VisualDensity.comfortable,
      ),
    );
  }


  Widget buttonUI(link, child,{pt:0.0,name:"", elevation:10.0, bgColor:MyColors.primaryColor,outlineColor:Colors.transparent, color:Colors.white}){
    return Padding(
      padding:EdgeInsets.symmetric(horizontal: pt),
      child: BounceIn(
        child: Card(
          elevation:elevation,
          color:Colors.transparent,
          shadowColor: MyColors.primaryColor,
          child: outlineUI(
            InkWell(
              onTap: link,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  text(""),
                  text(name, size:18.0, fw:FontWeight.w400, color:color, fontStyle: 'fredokaOne'),
                  child
                ],
              ),
            ).pSymmetric(v:5),
            bg:bgColor,
            outlineColor: outlineColor,
            radius: 10.0,
            // ht:0.0
          )
        )
      )
    );
  }


  
  Widget inputForm(String label,{
    valide(String v) ,save(String save), change(var v),
    type: TextInputType.text, iconL, iconR, showPwd:false, controller, initVal, 
    TextInputAction nextInput: TextInputAction.done,
  }) {
    return Theme(
      data: ThemeData(
        primaryColor: MyColors.primaryColor,
        primaryColorDark: Colors.red,
      ),
      child: TextFormField(
            initialValue: initVal,
            keyboardType: type,
            obscureText: showPwd,
            textInputAction: nextInput,
            style: TextStyle(height: 0.0),
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                 borderSide: BorderSide(color:Vx.indigo700,width: 0.5),
                 borderRadius: BorderRadius.all(Radius.circular(10.0)),

              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
              focusedBorder: new OutlineInputBorder(
                 borderSide: BorderSide(color:Vx.indigo700,width: 0.5),
                 borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
            
              labelText: label, prefixIcon: iconL, suffixIcon: iconR,
              labelStyle: TextStyle(color:MyColors.primaryColor),
              filled: true,
            ),
            validator: (value) => valide(value),
            onSaved:   (value) => save(value),
            onChanged: (value) => change(value),
            controller: controller,

          )
    );
  }




   Future<void> dialog(BuildContext context, Widget child) async {
        return showDialog<void>(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return new WillPopScope(
                  onWillPop: () async => false,
                  child: SimpleDialog(
                      contentPadding: EdgeInsets.zero,
                      elevation: 10.0,
                      backgroundColor: MyColors.flou1,
                      children: <Widget>[
                        VxBox(
                          child: child
                        ).width(Get.width/2).make().pSymmetric(v:20)
                      ], 
                  )
              );
            }
        );
      }

    Future<void> scanResult(context,int code, Function click) async {
      dialog(
        context,
        [
          text(
            code == 200 
            ? "Carnet Invalide"
            : "Carnet Valide",
            fontStyle: 'fredokaOne', 
            color: Vx.black, size:30.0, fw:FontWeight.w100
          ), 
          Lottie.asset(
            code == 200 
            ? "assets/cross2.json"
            : "assets/check.json",
            fit: BoxFit.contain,width: Get.width/2, repeat: false), 
          10.heightBox, 
          buttonUI(
              (){click();},
              text(""),
              name:"ok",
              bgColor: code == 200 ? MyColors.kRed : MyColors.kLightGreen,
              elevation: 0.0
            ),
        ].vStack()
      );
}

  Future<void> scanLoadUi(context, Function click) async {
      dialog(
        context,
        [
          text(
            "Verification", fontStyle: 'fredokaOne', 
            color: Vx.black, size:20.0, fw:FontWeight.w100
          ), 
          VxBox(
            child: "La vérification du carnet est actuellement en cours veillez patienter pour un moment."
              .text.black.size(10).make().p(10)
          ).white.roundedSM.make().p(10),
          10.heightBox, 
          Lottie.asset("assets/scanning.json", fit: BoxFit.contain, animate: true), 
          20.heightBox, 
          buttonUI(
              (){click();},
              text(""),
              name:"Fermer",
              bgColor: MyColors.kRed, 
              elevation: 0.0
            ),
        ].vStack()
      );
}




}