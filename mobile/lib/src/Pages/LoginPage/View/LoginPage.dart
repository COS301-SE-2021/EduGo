import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:mobile/src/Components/User/Controller/UserController.dart';
import 'package:momentum/momentum.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);
  static String id = 'login';

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  /////////////////////////  VARIABLES & FUNCTIONS  ////////////////////////////
  //Global key that is going to tell us about any change in Form() widget.
  GlobalKey<FormState> _loginFormkey = GlobalKey<FormState>();

  // Text controllers used to retrieve the current value of the input fields
  final email_text_controller = TextEditingController();
  final password_text_controller = TextEditingController();

  @override
  void dispose() {
    // Clean up the controllers when the widget is disposed.
    email_text_controller.dispose();
    password_text_controller.dispose();
    super.dispose();
  }
  //////////////////////////////////////////////////////////////////////////////

  @override
  Widget build(BuildContext context) {
    //////////////////////////////////  WIDGETS  /////////////////////////////////
    //These may include the following widgets: input fields, buttons, forms

    Widget login_user_heading = new Text(
      'User',
      key: Key('login_user_heading'),
      textDirection: TextDirection.ltr,
      style: const TextStyle(
          fontWeight: FontWeight.bold, color: Colors.black, fontSize: 60),
    );

    Widget login_registration_heading = new Text(
      'Registration',
      key: Key('login_registration_heading'),
      textDirection: TextDirection.ltr,
      style: const TextStyle(
          fontWeight: FontWeight.bold, color: Colors.black, fontSize: 60),
    );

    Widget email_input_widget = Padding(
      padding: const EdgeInsets.only(
        top: 100,
        left: 20,
        right: 20,
      ),
      //Email input field
      child: new TextFormField(
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

    Widget password_input_widget = Padding(
      padding: const EdgeInsets.only(
        top: 30,
        left: 20,
        right: 20,
      ),
      //password input field
      child: TextFormField(
        key: Key('login_password'),
        //Controller is notified when the text changes
        controller: password_text_controller,
        //Control when the auto validation should happen
        autovalidateMode: AutovalidateMode.always,
        //password is required, must be 6 digits long and must be numeric
        validator: MultiValidator([
          RequiredValidator(errorText: "* Required"),
          MinLengthValidator(8, errorText: "Invalid password"),
          PatternValidator(
              r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$',
              errorText: "Invalid password"), //Digits only
        ]),
        //type of keyboard to use for editing the text.
        keyboardType: TextInputType.number,
        //Input field UI
        style: TextStyle(),
        decoration:
            InputDecoration(border: OutlineInputBorder(), hintText: "Password"),
      ),
    );

    Widget login_button_widget = //Next button that leads to Registration Page
        Padding(
      key: Key('login_button'),
      padding: const EdgeInsets.only(top: 50),
      child: MaterialButton(
        onPressed: () => null, //TODO _submitForm(),
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

    Widget child = Scaffold(
        body: Form(
            key: _loginFormkey,
            child: Stack(key: Key('login_form'), children: <Widget>[
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
                          padding: const EdgeInsets.only(
                            top: 60,
                          ),
                          child: Column(
                            textDirection: TextDirection.ltr,
                            children: [
                              login_user_heading,
                              login_registration_heading,
                              email_input_widget,
                              password_input_widget,
                              login_button_widget,
                            ],
                          ))))
            ])));
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
