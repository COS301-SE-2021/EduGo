import 'package:flutter/material.dart';
import 'package:mobile/src/Components/User/Controller/UserController.dart';
import 'package:momentum/momentum.dart';

class LoginPage extends StatefulWidget {
  LoginPage();
  static String id = 'login';

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //////////////////////////////////  WIDGETS  /////////////////////////////////
  @override
  Widget build(BuildContext context) {
    return Column(
      textDirection: TextDirection.ltr,
      children: [
        Text(
          'User',
          textDirection: TextDirection.ltr,
          style: const TextStyle(
              fontWeight: FontWeight.bold, color: Colors.black, fontSize: 60),
        ),
        Text(
          'Registration',
          textDirection: TextDirection.ltr,
          style: const TextStyle(
              fontWeight: FontWeight.bold, color: Colors.black, fontSize: 60),
        ),
      ],
    );
    //////////////////////////////////////////////////////////////////////////////

    /////////////////////////////  VIEW RETURNED  ////////////////////////////////
    //return view
    /*return MomentumBuilder(
        controllers: [UserController],
        builder: (context, snapshot) {
          return child;
        });*/
    ////////////////////////////////////////////////////////////////////////////
  }
}
