import 'package:fl_country_code_picker/fl_country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/providers/auth.dart';
import 'package:flutter_app/widgets/widgets.dart';
import 'package:provider/provider.dart';

final ui = WidgetsUi();

final email = TextEditingController();
final firstName = TextEditingController();
final lastName = TextEditingController();
final phone = TextEditingController();
final password = TextEditingController();

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key key}) : super(key: key);

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  var showPwd = true;

  String dialCode = '+224';
  String country = 'GN';
  final countryPicker = const FlCountryCodePicker();
  

  Future<dynamic> submit(BuildContext ctx) async {

      /// to close keyboard when the button is clicked
      FocusScope.of(context).requestFocus(FocusNode());

      /// if validate is not true return null
      if (!_formKey.currentState.validate()) 
        return;

      /// else save state and passing data to http
      _formKey.currentState.save();
      var data = {
        'email': email.text, 
        'first_name': firstName.text, 
        'last_name': lastName.text, 
        'phone_number': dialCode+''+phone.text,
        'country': country,
        'password': password.text
      };
      await Provider.of<AuthVM>(context, listen: false).signup(data);
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
                        "Registration",
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 5.0,),
                      Text(
                        "Ad ut sit ex exercitation anim\neiusmod mollit eu ad.",
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
                      ? SizedBox(
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                            strokeWidth: 3.0,
                          ),
                          height: 30,
                          width: 30,
                        )
                      :  Text(
                          "Signup",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0,
                            color: Colors.white
                          ),
                        ),
                    width: double.infinity,
                    color:  Colors.orange,
                    overColor:Colors.white,
                    onPressed: () async {
                      await submit(context);
                      if(authState.error != ""){
                        WidgetsUi().toast(
                          context: context,
                          message: authState.error,
                          bColor: Colors.red
                        );
                      } else if(authState.status == 200){
                        Navigator.pop(context);
                      }
                    }
                  ),
                ),
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
            "First Name", 
            nextInput: TextInputAction.next, 
            validate: (v) {
              if (v.isEmpty || v == null) return  "incorrect first name";
            }, 
            controller: firstName, 
            onChange:(_) {},
            iconL: const Icon(Icons.account_circle_outlined, color: Colors.orange),
          ),

          SizedBox(height: 20.0),

          ui.inputForm(
            "Last Name", 
            nextInput: TextInputAction.next, 
            validate: (v) {
              if (v.isEmpty || v == null) return  "incorrect last name";
            }, 
            controller: lastName, 
            onChange:(_) {},
            iconL: const Icon(Icons.account_circle_outlined, color: Colors.orange),
          ),

          SizedBox(height: 20.0),

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

          SizedBox(height: 20.0),
          ui.inputForm(
            "Phone Number", 
            nextInput: TextInputAction.next, 
            validate: (v) {
              if (v.isEmpty || v == null) return  "incorrect phone number";
            }, 
            controller: phone, 
            onChange:(_) {},
            iconL: GestureDetector(
              onTap: () async {
                  final code = await countryPicker.showPicker(context: context);
                  if (code != null)  {
                    print(code);
                    setState(() {
                      dialCode = code.dialCode;
                      country = code.code;
                    });
                  }
              },
              child: Container(
                padding: const EdgeInsets.all(10.0),
                margin: const EdgeInsets.all(10),
                decoration: const BoxDecoration(
                    color: Colors.orange,
                    borderRadius: BorderRadius.all(Radius.circular(5.0))
                ),
                child: Text(dialCode,
                    style: const TextStyle(color: Colors.white)
                ),
              ),
            ),
            type: TextInputType.phone
          ),

          SizedBox(height: 20.0),

          ui.inputForm(
            "Password", 
            validate: (v) {
              if (v.isEmpty || v == null) return "incorrect password";
            }, 
            controller: password,
            iconL: const Icon(Icons.lock,color: Colors.orange),
            showPwd: showPwd, 
            onChange:(_) {},
            iconR: IconButton(
              onPressed: () => setState(() {showPwd = !showPwd; }),
              icon: Icon(
                showPwd ? Icons.close : Icons.remove_red_eye_sharp,
                color:Colors.grey[400]
              ),
            )
          )
        ],
      ),
    );
  }
}
