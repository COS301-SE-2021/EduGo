import 'package:flutter/material.dart';
import 'package:mobile/mockApi.dart';
import 'package:mobile/src/Components/User/Controller/UserController.dart';
import 'package:mobile/src/Components/User/Models/UserModel.dart';

//Imported custom components, pages and packages
import 'package:mobile/src/Components/mobile_page_layout.dart';
import 'package:mobile/src/Pages/RegistrationPage/View/RegistrationPage.dart';
import 'package:momentum/momentum.dart';
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
  // Text controllers used to retrieve the current value of the input fields
  final email_text_controller = TextEditingController();
  final code_text_controller = TextEditingController();
//loginController;
  @override
  void dispose() {
    // Clean up the controllers when the widget is disposed.
    email_text_controller.dispose();
    code_text_controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //Get a specific controller (UserController) to call needed functions (verify)
    UserController userController = Momentum.of<UserController>(context);

    Widget child = Stack(
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
                      controller: email_text_controller,
                      style: TextStyle(),
                      decoration: InputDecoration(
                          border: OutlineInputBorder(), hintText: "Email"),
                    ),
                  ),
                  //Code input field
                  Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: TextField(
                      controller: code_text_controller,
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
                        if (userController.verify(
                                email: email_text_controller.text,
                                code: code_text_controller.text) ==
                            true) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (scontext) => RegistrationPage()),
                          );
                        } else {
                          print("unsuccessful");
                        }
                      },
                      height: 60,
                      color: Colors.black,
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              "Next",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
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
    );
    //return view
    return MobilePageLayout(
        false, //no side bar
        false, //no bottom bar
        MomentumBuilder(
            controllers: [UserController],
            builder: (context, snapshot) {
              var user = snapshot<UserModel>();
              return child;
            }));
  }
}
