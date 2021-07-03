import 'package:edugo_web_app/src/Pages/Home/View/Home.dart';
import 'package:edugo_web_app/src/Pages/VirtualEntity/View/CreateVirtualEntityView.dart';
import 'package:flutter/material.dart';

class SignInView extends StatelessWidget {
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
                      builder: (context) => CreateVirtualEntityView()),
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
