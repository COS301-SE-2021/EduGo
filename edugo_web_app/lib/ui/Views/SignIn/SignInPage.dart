import 'package:edugo_web_app/ui/Views/SignIn/SignInPageContent.dart';
import 'package:flutter/material.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Container(
                          width: MediaQuery.of(context).size.width / 2,
                          height: MediaQuery.of(context).size.height,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Color.fromRGBO(255, 247, 223, 1.0),
                                Color.fromRGBO(255, 251, 240, 1.0)
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                          ),
                          child: SignInPageContent())
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                          width: MediaQuery.of(context).size.width / 2,
                          height: MediaQuery.of(context).size.height,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Color.fromRGBO(203, 203, 203, 1.0),
                                Color.fromRGBO(232, 226, 226, 1.0)
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 40.0),
                            child: Image.asset(
                              "../assets/images/signin_image.png",
                              width: MediaQuery.of(context).size.width / 2,
                            ),
                          ))
                    ],
                  ),
                ])));
  }
}
/* 
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

*/
