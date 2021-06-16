import 'package:edugo_web_app/ui/Views/Landing/EduGoHome.dart';
import 'package:flutter/material.dart';

class SignInPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          child: Row(
        children: <Widget>[
          MaterialButton(
              onPressed: () {
                //Insert login form field
                //Run form field checks
                //Call login service
              },
              child: Text("Sign In")),
          MaterialButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => EduGoHome()),
                );
              },
              child: Text("<< Back"))
        ],
      )),
    );
  }
}
