import 'package:edugo_web_app/ui/Views/Landing/EduGoHome.dart';
import 'package:edugo_web_app/ui/Views/subject/SubjectsPage.dart';
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
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SubjectsPage()),
                );
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
