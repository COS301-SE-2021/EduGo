import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';

//email, password
class LoginPage extends StatefulWidget {
  LoginPage();
  static String id = "login";

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  /////////////////////////////////  VARIABLES  ////////////////////////////////
  //Global key that is going to tell us about any change in Form() widget.
  GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  // Text controllers used to retrieve the current value of the input fields
  final email_text_controller = TextEditingController();
  final code_text_controller = TextEditingController();

  //Global key that is going to tell us about any change in Form() widget.
  GlobalKey<FormState> _login_form_key = GlobalKey<FormState>();
  //////////////////////////////////////////////////////////////////////////////

  /////////////////////////////////  FUNCTIONS  ////////////////////////////////
  @override
  void dispose() {
    // Clean up the controllers when the widget is disposed.
    email_text_controller.dispose();
    code_text_controller.dispose();
    super.dispose();
  }
  //////////////////////////////////////////////////////////////////////////////

  @override
  Widget build(BuildContext context) {
    ////////////////////////////////  WIDGETS  /////////////////////////////////
    Widget page_heading_user = Text(
      "User",
      style: const TextStyle(
          fontWeight: FontWeight.bold, color: Colors.black, fontSize: 60),
    );

    Widget page_heading_registration = Text("Registration",
        style: const TextStyle(
            fontWeight: FontWeight.bold, color: Colors.black, fontSize: 60));

    Widget email_input_widget = Padding(
      padding: const EdgeInsets.only(top: 100),
      //Email input field
      child: TextFormField(
        key: Key('login_email'),
        //Controller is notified when the text changes
        controller: email_text_controller,
        //Control when the auto validation should happen
        autovalidateMode: AutovalidateMode.always,
        //Email is required and must be valid
        validator: MultiValidator([
          RequiredValidator(errorText: "* Required"),
          EmailValidator(errorText: "Invalid email address"),
        ]),
        //type of keyboard to use for editing the text.
        keyboardType: TextInputType.emailAddress,
        //Input field UI
        style: TextStyle(),
        decoration:
            InputDecoration(border: OutlineInputBorder(), hintText: "Email"),
      ),
    );

    Widget login_button_widget = Padding(
      key: Key('login_button'),
      padding: const EdgeInsets.only(top: 50),
      child: MaterialButton(
        onPressed: () => null,
        height: 60,
        color: Colors.black,
        child: Row(
          children: <Widget>[
            Expanded(
              child: Text(
                "Login",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
            Icon(Icons.login_outlined, color: Colors.white),
          ],
        ),
      ),
    );
    ////////////////////////////////////////////////////////////////////////////

    //page to be displayed
    Widget child = Form(
        key: _login_form_key,
        child: Stack(
          children: <Widget>[
            //Align form
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
                          page_heading_user,
                          page_heading_registration,
                          email_input_widget,
                        ],
                      ))),
            )
          ],
        ));
    //page returned
    return child;
  }
}
/*import 'package:flutter/material.dart';

//Imported custom components, pages and packages
import 'package:mobile/src/Components/mobile_page_layout.dart';
import 'package:mobile/src/Components/User/Controller/UserController.dart';
import 'package:mobile/src/Pages/RegistrationPage/View/RegistrationPage.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:momentum/momentum.dart';

//This page is used to verify if student is already allocated to an
//organization by an educator
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

  //Global key that is going to tell us about any change in Form() widget.
  GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  @override
  void dispose() {
    // Clean up the controllers when the widget is disposed.
    email_text_controller.dispose();
    code_text_controller.dispose();
    super.dispose();
  }

  //empty the input fields
  void clearTextInput() {
    email_text_controller.clear();
    code_text_controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    ///////////////////////  VARIABLES & FUNCTIONS  ////////////////////////////
    //Get a specific controller (UserController) to call needed functions (verify)
    UserController userController =
        Momentum.controller<UserController>(context);

    //When the form is submitted
    void _submitForm() {
      if (userController.verify(
              email: email_text_controller.text,
              code: code_text_controller.text) ==
          true) {
        //Leads to home page
        Navigator.pushNamed(context, RegistrationPage.id);
        return;
      }

      clearTextInput();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Unsuccessful Registration: unverified user"),
          backgroundColor: Colors.red,
        ),
      );
    }
    ////////////////////////////////////////////////////////////////////////////

    ////////////////////////////////  WIDGETS  /////////////////////////////////
    //These may include the following widgets: input fields, buttons, forms
    Widget email_input_widget = Padding(
      padding: const EdgeInsets.only(top: 100),
      //Email input field
      child: TextFormField(
        key: Key('email_input_field'),
        //Controller is notified when the text changes
        controller: email_text_controller,
        //Control when the auto validation should happen
        autovalidateMode: AutovalidateMode.always,
        //Email is required and must be valid
        validator: MultiValidator([
          RequiredValidator(errorText: "* Required"),
          EmailValidator(errorText: "Invalid email address"),
        ]),
        //type of keyboard to use for editing the text.
        keyboardType: TextInputType.emailAddress,
        //Input field UI
        style: TextStyle(),
        decoration:
            InputDecoration(border: OutlineInputBorder(), hintText: "Email"),
      ),
    );

    Widget code_input_widget = Padding(
      padding: const EdgeInsets.only(top: 30),
      //Code input field
      child: TextFormField(
        key: Key('code_input_field'),
        //Controller is notified when the text changes
        controller: code_text_controller,
        //Control when the auto validation should happen
        autovalidateMode: AutovalidateMode.always,
        //Code is required, must be 6 digits long and must be numeric
        validator: MultiValidator([
          RequiredValidator(errorText: "* Required"),
          LengthRangeValidator(
              min: 5, max: 5, errorText: "Invalid Activation Code"),
          PatternValidator("[0-9]{5}",
              errorText: "Invalid Activation Code"), //Digits only
        ]),
        //type of keyboard to use for editing the text.
        keyboardType: TextInputType.number,
        //Input field UI
        style: TextStyle(),
        decoration: InputDecoration(
            border: OutlineInputBorder(), hintText: "Activation Code"),
      ),
    );

    Widget next_button_widget = //Next button that leads to Registration Page
        Padding(
      key: Key('next_button'),
      padding: const EdgeInsets.only(top: 50),
      child: MaterialButton(
        onPressed: () => _submitForm(),
        height: 60,
        color: Colors.black,
        child: Row(
          children: <Widget>[
            Expanded(
              child: Text(
                "Next",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
            Icon(Icons.login_outlined, color: Colors.white),
          ],
        ),
      ),
    );

    //page to be displayed
    Widget child = Form(
      key: _formkey,
      child: Stack(
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
                    email_input_widget,
                    code_input_widget,
                    next_button_widget,
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
    ////////////////////////////////////////////////////////////////////////////

    ///////////////////////////  VIEW RETURNED  ////////////////////////////////
    //return view
    return MobilePageLayout(
        false, //no side bar
        false, //no bottom bar
        MomentumBuilder(
            controllers: [UserController],
            builder: (context, snapshot) {
              return child;
            }));
    ////////////////////////////////////////////////////////////////////////////
  }
}
*/