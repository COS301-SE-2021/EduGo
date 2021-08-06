import 'package:flutter/material.dart';
import 'package:mobile/src/Components/User/Controller/UserController.dart';
import 'package:momentum/momentum.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);
  static String id = 'login';

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //////////////////////////////////  WIDGETS  /////////////////////////////////
  @override
  Widget build(BuildContext context) {
    Widget child = Column(
      textDirection: TextDirection.ltr,
      children: [
        new Text(
          'User',
          key: Key('login_user_heading'),
          textDirection: TextDirection.ltr,
          style: const TextStyle(
              fontWeight: FontWeight.bold, color: Colors.black, fontSize: 60),
        ),
        new Text(
          'Registration',
          key: Key('login_registration_heading'),
          textDirection: TextDirection.ltr,
          style: const TextStyle(
              fontWeight: FontWeight.bold, color: Colors.black, fontSize: 60),
        ),
      ],
    );
    //////////////////////////////////////////////////////////////////////////////

    /////////////////////////////  VIEW RETURNED  ////////////////////////////////
    //return view
    return MomentumBuilder(
        controllers: [UserController],
        builder: (context, snapshot) {
          return child;
        });
    ////////////////////////////////////////////////////////////////////////////
  }
}
