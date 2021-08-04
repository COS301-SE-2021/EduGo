import 'package:flutter/material.dart';

//Imported custom components, pages and packages
import 'package:mobile/src/Components/mobile_page_layout.dart';
import 'package:mobile/src/Pages/RegistrationPage/View/RegistrationPage.dart';
//import 'package:momentum/momentum.dart';
//controller

//Verify if student is already allocated to an organization by an educator
class RegistrationVerificationPage extends StatefulWidget {
  RegistrationVerificationPage();
  static String id = "registration_verification";

  @override
  _RegistrationVerificationPageState createState() =>
      _RegistrationVerificationPageState();
}

class _RegistrationVerificationPageState
    extends State<RegistrationVerificationPage> {
  @override
  Widget build(BuildContext context) {
    //return view
    return MobilePageLayout(
      false, //no side bar
      false, //no bottom bar
      Stack(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              border: Border.all(
                style: BorderStyle.solid,
                color: Colors.green,
              ),
            ),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(top: 60),
                child: Column(
                  children: [
                    //Page title: User Registration
                    Text(
                      "User",
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 60),
                    ),
                    Text("Verification",
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: 60)),
                    //Email input field
                    Padding(
                      padding: const EdgeInsets.only(top: 100),
                      child: TextField(
                        style: TextStyle(),
                        decoration: InputDecoration(
                            border: OutlineInputBorder(), hintText: "Email"),
                      ),
                    ),
                    //Code input field
                    Padding(
                      padding: const EdgeInsets.only(top: 30),
                      child: TextField(
                        style: TextStyle(),
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: "Activation Code"),
                      ),
                    ),
                    //TODO button should send request: RegistrationVerificationModel(this.email, this.activation_code);
                    //Next button that leads to Registration Page
                    Padding(
                      padding: const EdgeInsets.only(top: 100),
                      child: MaterialButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (scontext) => RegistrationPage()),
                          );
                        },
                        height: 60,
                        color: Colors.black,
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: Text(
                                "Next",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ),
                            ),
                            Icon(Icons.login_outlined, color: Colors.white),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
