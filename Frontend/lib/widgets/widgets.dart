import 'package:flutter/material.dart';

class WidgetsUi{



  // input form ui 
  Widget inputForm(String label,{
    @required Function(String v) validate, @required Function(String v) onChange,
    maxLines = 1,
    TextInputAction nextInput = TextInputAction.done,
    type = TextInputType.text,
    iconL,
    iconR,
    showPwd = false,
    thousandFormat =false,
    controller,
    initVal, 
    border =false
  }) {
    return TextFormField(
      initialValue: initVal,
      keyboardType: type,
      obscureText: showPwd,
      textInputAction: nextInput,
      maxLines: maxLines,
      style: const TextStyle(height:0.5),
      decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color:Colors.red, width: 0.0),
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
          ),
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color:Colors.red, width: 0.0),
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
          ),
          labelText: label,
          prefixIcon: iconL,
          suffixIcon: iconR,
          labelStyle: const TextStyle(color: Colors.black),
          filled: true,
          fillColor: Colors.black.withOpacity(0.1)),
      validator: (value) => validate(value),
      onChanged: (value) => onChange(value),
      controller: controller,
    );
  }


  ScaffoldFeatureController toast({BuildContext context, String message, Color textColor = Colors.white , Color bColor = Colors.black}){
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: TextStyle(
            color: textColor
          ),
        ),
        backgroundColor: bColor,
      )
    );
  }




      // button ui design
  Widget button({
      @required Widget child, double elevation =0.0, outlineColor = Colors.orange, 
      Function onPressed,shape = 0.0, Color shadow = Colors.transparent, 
      Color color = Colors.blue,Color overColor = Colors.black, double width = 200.0, double height = 60.0
    }){
    return ElevatedButton(
      onPressed: onPressed,
      child: child,
      style: ButtonStyle(
        animationDuration: Duration(microseconds: 200),
        enableFeedback: true,
        backgroundColor: MaterialStateProperty.all(color),
        elevation: MaterialStateProperty.all(elevation),
        minimumSize: MaterialStateProperty.all(Size(width,height)),
        overlayColor: MaterialStateProperty.all(overColor.withOpacity(0.3)),
        shadowColor: MaterialStateProperty.all(shadow),
        visualDensity: VisualDensity.comfortable,
        shape: MaterialStateProperty.all(RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(shape), 
          side: BorderSide(width: 1.0, color: outlineColor),
        )),
      ),
    );
  }
}