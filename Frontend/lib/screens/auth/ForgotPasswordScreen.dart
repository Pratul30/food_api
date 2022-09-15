import 'package:flutter/material.dart';
import 'package:flutter_app/providers/view%20models/auth.vm.dart';
import 'package:flutter_app/widgets/loading.widget.dart';
import 'package:flutter_app/widgets/widgets.dart';
import 'package:provider/provider.dart';

final ui = WidgetsUi();

final email = TextEditingController();

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key key}) : super(key: key);

  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  

  Future<dynamic> submit(BuildContext ctx) async {

      /// to close keyboard when the button is clicked
      FocusScope.of(context).requestFocus(FocusNode());

      /// if validate is not true return null
      if (!_formKey.currentState.validate()) 
        return;

      /// else save state and passing data to http
      _formKey.currentState.save();
      var data = {'email': email.text};
      await Provider.of<AuthVM>(context, listen: false).forgotPassword(data);
  }





  @override
  Widget build(BuildContext context) {
    final authState = Provider.of<AuthVM>(context, listen: true);
    return Scaffold(
        appBar: AppBar(
          elevation: 0.0, 
          foregroundColor: Colors.orange,
          backgroundColor: Colors.transparent, 
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 30),
                  child: Image.asset(
                    'assets/images/menus/ic_food_express.png', 
                    width: MediaQuery.of(context).size.width/1.5,
                    fit: BoxFit.contain
                  ),
                ),
        
                Align(
                  alignment: Alignment.topLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Forgot Password",
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 5.0,),
                      Text(
                        "Occaecat ex incididunt proident\nofficia velit anim nulla.",
                        style: TextStyle(
                          fontSize: 14.0,
                          color: Colors.grey[600]
                        ),
                      ),
        
                      SizedBox(height: 20.0),
                    ],
                  )
                ),
        
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: form(),
                ),
              
        
        
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: ui.button(
                    child: authState.isLoading
                      ? LoadingWidget()
                      :  Text(
                          "Forgot password",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0,
                            color: Colors.white
                          ),
                        ),
                    width: double.infinity,
                    color:  Colors.orange,
                    overColor:Colors.white,
                    onPressed: (){
                      submit(context);
                    }
                  ),
                ),


                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children:[
                      Text(
                        "Don\'t you have an account?",
                        style: TextStyle(
                          fontSize: 14.0,
                          color: Colors.grey[600],
                        ),
                      ),
                      TextButton(
                        onPressed: () => Navigator.popAndPushNamed(context, 'signup'),
                        child: Text(
                          "Signup",
                          style: TextStyle(
                            fontSize: 12.0,
                            color: Colors.orange[600],
                            fontWeight: FontWeight.w700,
                            decoration: TextDecoration.underline
                          ),
                        ),
                      )
                    ]
                  ),
                )
              ]
            ),
          ),
        )
    );
  }



  Widget form() {
    return Form(
      key: _formKey,
      child: Column(
        children: [

          ui.inputForm(
            "Email", 
            nextInput: TextInputAction.next, 
            validate: (v) {
              if (v.isEmpty || v == null) return  "incorrect email";
            }, 
            controller: email, 
            onChange:(_) {},
            iconL: const Icon(Icons.mail, color: Colors.orange),
            type: TextInputType.emailAddress
          ),
        ],
      ),
    );
  }
}
