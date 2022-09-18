import 'package:flutter/material.dart';
import 'package:flutter_app/providers/view%20models/auth.vm.dart';
import 'package:flutter_app/widgets/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

final ui = WidgetsUi();

final email = TextEditingController();
final password = TextEditingController();

class SigninScreen extends StatefulWidget {
  const SigninScreen({Key key}) : super(key: key);

  @override
  _SigninScreenState createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  final _formKey = GlobalKey<FormState>();
  var showPwd = true;

  Future<dynamic> submit(BuildContext ctx) async {
    /// to close keyboard when the button is clicked
    FocusScope.of(context).requestFocus(FocusNode());

    /// if validate is not true return null
    if (!_formKey.currentState.validate()) return;

    /// else save state and passing data to http
    _formKey.currentState.save();
    var data = {'email': email.text, 'password': password.text};
    await Provider.of<AuthVM>(ctx, listen: false).signin(data);
  }

  @override
  Widget build(BuildContext context) {
    final authState = Provider.of<AuthVM>(context);
    return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          foregroundColor: Colors.orange,
          backgroundColor: Colors.transparent,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 30),
                child: Image.asset('assets/images/menus/ic_food_express.png',
                    width: MediaQuery.of(context).size.width / 1.5,
                    fit: BoxFit.contain),
              ),
              Align(
                  alignment: Alignment.topLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Welcome",
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.purple,
                        ),
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      Text(
                        "Please enter your login credentials",
                        style:
                            TextStyle(fontSize: 14.0, color: Colors.grey[600]),
                      ),
                      SizedBox(height: 20.0),
                    ],
                  )),
              Container(
                margin: EdgeInsets.only(bottom: 20),
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: form(),
              ),
              // Padding(
              //   padding: const EdgeInsets.symmetric(vertical: 15),
              //   child: Align(
              //     alignment: Alignment.topRight,
              //     child: TextButton(
              //       onPressed: () => Navigator.pushNamed(context, 'forgot_pwd'),
              //       child: Text(
              //         "Forgot password?",
              //         style: TextStyle(
              //             fontSize: 14.0,
              //             color: Colors.grey[600],
              //             decoration: TextDecoration.underline),
              //       ),
              //     ),
              //   ),
              // ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: ui.button(
                    child: authState.isLoading
                        ? SizedBox(
                            child: CircularProgressIndicator(
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.white),
                              strokeWidth: 3.0,
                            ),
                            height: 30,
                            width: 30,
                          )
                        : Text(
                            "Sign In",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20.0,
                                color: Colors.white),
                          ),
                    width: double.infinity,
                    color: Colors.orange,
                    overColor: Colors.white,
                    onPressed: () async {
                      await submit(context);
                      if (authState.error != "") {
                        WidgetsUi().toast(
                          context: context,
                          message: authState.error,
                          //bColor: Colors.red
                        );
                      } else if (authState.status == 200) {
                        Navigator.pushNamedAndRemoveUntil(
                            context, 'home', (route) => false);
                      }
                    }),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        "Don\'t have an account?",
                        style: TextStyle(
                          fontSize: 14.0,
                          color: Colors.grey[600],
                        ),
                      ),
                      TextButton(
                        onPressed: () => Navigator.pushNamed(context, 'signup'),
                        child: Text(
                          "Sign Up",
                          style: TextStyle(
                              fontSize: 12.0,
                              color: Colors.purple,
                              fontWeight: FontWeight.w700,
                              decoration: TextDecoration.underline),
                        ),
                      )
                    ]),
              )
            ]),
          ),
        ));
  }

  Widget form() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          ui.inputForm("Email", nextInput: TextInputAction.next, validate: (v) {
            if (v.isEmpty || v == null) return "incorrect email";
          },
              controller: email,
              onChange: (_) {},
              iconL: const Icon(Icons.mail, color: Colors.orange),
              type: TextInputType.emailAddress),
          SizedBox(height: 20.0),
          ui.inputForm("Password", validate: (v) {
            if (v.isEmpty || v == null) return "incorrect password";
          },
              controller: password,
              iconL: const Icon(Icons.lock, color: Colors.orange),
              showPwd: showPwd,
              onChange: (_) {},
              iconR: IconButton(
                onPressed: () => setState(() {
                  showPwd = !showPwd;
                }),
                icon: Icon(
                    showPwd ? FontAwesomeIcons.eyeSlash : FontAwesomeIcons.eye,
                    color: Colors.grey[400]),
              ))
        ],
      ),
    );
  }
}
