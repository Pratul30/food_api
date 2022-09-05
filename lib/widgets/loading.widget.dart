import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  LoadingWidget({ Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.black)
          ),
          height: 40,
          width: 40,
        ),
        SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.all(5),
          child: Text("Loading...", style: TextStyle(
            color: Colors.black
          ),)
        )
      ],
    );
  }
}
