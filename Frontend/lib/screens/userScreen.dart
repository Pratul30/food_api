import 'package:flutter/material.dart';
import 'package:flutter_app/providers/view%20models/auth.vm.dart';
import 'package:flutter_app/widgets/widgets.dart';
import 'package:provider/provider.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({Key key}) : super(key: key);

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  @override
  Widget build(BuildContext context) {
    final _user = Provider.of<AuthVM>(context);
    return Scaffold(
      appBar: AppBar(
          centerTitle: false,
          elevation: 0.0,
          backgroundColor: Colors.orange,
          title: Text(
            "Profile",
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.w800,
            ),
          )),
      backgroundColor: Colors.grey[100],
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 10),
          listTile(Icons.account_circle, "First name", _user.user.lastName),
          listTile(Icons.account_circle, "Last name", _user.user.firstName),
          listTile(Icons.email, "Email", _user.user.email),
          SizedBox(height: 10),
          Divider(
            color: Colors.black,
          ),
          InkWell(
            onTap: () async {
              await _user.logout();
              if (_user.error != "") {
                WidgetsUi().toast(
                    context: context, message: _user.error, bColor: Colors.red);
              } else if (_user.status == 200) {
                Navigator.pushNamedAndRemoveUntil(
                    context, 'signin', (route) => false);
              }
            },
            child: ListTile(
                leading: Icon(Icons.logout, size: 30.0),
                title: Text(
                  "Log out",
                  style: TextStyle(
                      color: Colors.grey[600], fontWeight: FontWeight.bold),
                ),
                trailing: _user.isLoading
                    ? SizedBox(
                        child: CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.orange),
                          strokeWidth: 3.0,
                        ),
                        height: 20,
                        width: 20,
                      )
                    : Icon(Icons.chevron_right, size: 30.0)),
          ),
        ],
      ),
    );
  }

  Widget listTile(IconData icon, String subTitle, String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
      child: ListTile(
        leading: Icon(icon, size: 30.0),
        subtitle: Text(
          subTitle,
          style:
              TextStyle(color: Colors.grey[600], fontWeight: FontWeight.w500),
        ),
        title: Text(
          title,
          style: TextStyle(
              fontSize: 20.0,
              color: Colors.grey[600],
              fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
