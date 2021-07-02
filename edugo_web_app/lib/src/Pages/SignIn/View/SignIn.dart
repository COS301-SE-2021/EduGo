import 'package:edugo_web_app/src/Pages/CreateVirtualEntity/View/CreateVirtualEntity.dart';
import 'package:edugo_web_app/src/Pages/Home/Home.dart';
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
                  MaterialPageRoute(
                      builder: (context) => CreateVirtualEntity()),
                );
              },
              child: Text("Sign In")),
          MaterialButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Home()),
                );
              },
              child: Text("<< Back"))
        ],
      )),
    );
  }
}
