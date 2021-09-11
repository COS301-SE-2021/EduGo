//https://pub.dev/packages/reactive_forms
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:mobile/src/Components/Common/ValidationClasses.dart';
import 'package:mobile/src/Components/User/Controller/UserController.dart';
import 'package:mobile/src/Components/mobile_page_layout.dart';
import 'package:mobile/src/Pages/LoginPage/View/LoginPage.dart';
import 'package:mobile/src/Pages/RegistrationPage/View/RegistrationVerificationPage.dart';
import 'package:momentum/momentum.dart';

class RegistrationPage extends StatefulWidget {
  static const registrationPageKey = Key('registrationPageKey');
  RegistrationPage(Key key) : super(key: registrationPageKey);
  static String id = "registration";

  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  /////////////////////////  VARIABLES & FUNCTIONS  ////////////////////////////

  // Text controllers used to retrieve the current value of the input fields
  final usernameTextController = TextEditingController();
  final passwordTextController = TextEditingController();
  final emailTextController = TextEditingController();
  final firstNameTextController = TextEditingController();
  final lastNameTextController = TextEditingController();

  //Snack bar that displays success or error message
  late SnackBar snackbarWidget;
  String snackbarMsg = '';

  @override
  void dispose() {
    // Clean up the controllers when the widget is disposed.
    usernameTextController.dispose();
    passwordTextController.dispose();
    emailTextController.dispose();
    firstNameTextController.dispose();
    lastNameTextController.dispose();
    super.dispose();
  }

  //snackbar to show error messages
  void _showSnackbar(String msg) {
    snackbarMsg = msg;
    ScaffoldMessenger.of(context).showSnackBar(snackbarWidget);
  }
  ////////////////////////////// WIDGETS //////////////////////////////////////

  @override
  Widget build(BuildContext context) {
    //Get a specific controller (UserController) to call needed functions (register)
    UserController userController =
        Momentum.controller<UserController>(context);
    //Page Title widget
    Widget _pageTitle = Text(
      "User Registration",
      key: Key('regPageHeading'),
      style: const TextStyle(
          fontWeight: FontWeight.bold, color: Colors.black, fontSize: 24),
    );

    //Username input field
    Widget _usernameField = FractionallySizedBox(
      widthFactor: 0.8,
      alignment: Alignment.center,
      child: Padding(
        padding: const EdgeInsets.only(
          top: 30,
        ),
        child: new TextFormField(
          controller: usernameTextController,
          autovalidateMode: AutovalidateMode.always,
          validator: MultiValidator([
            RequiredValidator(errorText: "* Required"),
            LengthRangeValidator(min: 4, max: 20, errorText: 'Invalid username')
          ]),
          style: TextStyle(),
          decoration: InputDecoration(
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                    color: Color.fromARGB(255, 97, 211, 87), width: 2.0),
              ),
              border: OutlineInputBorder(),
              hintStyle: TextStyle(fontSize: 20),
              hintText: "Username",
              prefixIcon: Icon(Icons.person)),
        ),
      ),
    );
    //First Name input field
    Widget _firstNameField = FractionallySizedBox(
      widthFactor: 0.8,
      alignment: Alignment.center,
      child: Padding(
        padding: const EdgeInsets.only(
          top: 30,
        ),
        child: new TextFormField(
          controller: firstNameTextController,
          autovalidateMode: AutovalidateMode.always,
          validator: MultiValidator([
            RequiredValidator(errorText: "* Required"),
            LengthRangeValidator(min: 4, max: 20, errorText: 'Invalid name')
          ]),
          style: TextStyle(),
          decoration: InputDecoration(
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                    color: Color.fromARGB(255, 97, 211, 87), width: 2.0),
              ),
              border: OutlineInputBorder(),
              hintStyle: TextStyle(fontSize: 20),
              hintText: "First Name",
              prefixIcon: Icon(Icons.person_add)),
        ),
      ),
    );
    //Last Name input field
    Widget _lastNameField = FractionallySizedBox(
      widthFactor: 0.8,
      alignment: Alignment.center,
      child: Padding(
        padding: const EdgeInsets.only(
          top: 30,
        ),
        child: new TextFormField(
          controller: lastNameTextController,
          autovalidateMode: AutovalidateMode.always,
          validator: MultiValidator([
            RequiredValidator(errorText: "* Required"),
            LengthRangeValidator(min: 4, max: 20, errorText: 'Invalid name')
          ]),
          style: TextStyle(),
          decoration: InputDecoration(
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                    color: Color.fromARGB(255, 97, 211, 87), width: 2.0),
              ),
              border: OutlineInputBorder(),
              hintStyle: TextStyle(fontSize: 20),
              hintText: "Last Name",
              prefixIcon: Icon(Icons.person_add_alt_1)),
        ),
      ),
    );
    //Email input field
    Widget _emailField = FractionallySizedBox(
      widthFactor: 0.8,
      alignment: Alignment.center,
      child: Padding(
        padding: const EdgeInsets.only(
          top: 30,
        ),
        child: new TextFormField(
          controller: emailTextController,
          autovalidateMode: AutovalidateMode.always,
          validator: MultiValidator([
            RequiredValidator(errorText: "* Required"),
            EmailValidator(errorText: "Invalid email address"),
          ]),
          style: TextStyle(),
          decoration: InputDecoration(
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                  color: Color.fromARGB(255, 97, 211, 87), width: 2.0),
            ),
            border: OutlineInputBorder(),
            hintStyle: TextStyle(fontSize: 20),
            hintText: "Email",
            prefixIcon: Icon(Icons.email_outlined),
          ),
        ),
      ),
    );

    //Password input field
    Widget _passwordField = FractionallySizedBox(
      widthFactor: 0.8,
      alignment: Alignment.center,
      child: Padding(
        padding: const EdgeInsets.only(
          top: 30,
        ),
        child: new TextFormField(
          controller: passwordTextController,
          autovalidateMode: AutovalidateMode.always,
          validator: MultiValidator([
            RequiredValidator(errorText: "* Required"),
            MinLengthValidator(8, errorText: "Invalid password"),
            PatternValidator(
                r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$',
                errorText: "Invalid password"),
          ]),
          obscureText: true,
          style: TextStyle(),
          decoration: InputDecoration(
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                  color: Color.fromARGB(255, 97, 211, 87), width: 2.0),
            ),
            border: OutlineInputBorder(),
            hintStyle: TextStyle(fontSize: 20),
            hintText: "Password",
            prefixIcon: Icon(Icons.visibility_off),
          ),
        ),
      ),
    );

    //Register button
    Widget _regButton = FractionallySizedBox(
      widthFactor: 0.7,
      alignment: Alignment.center, //Alignment.centerRight,
      child: Padding(
        padding: const EdgeInsets.only(
          top: 30,
          bottom: 30,
        ),
        child: MaterialButton(
          elevation: 40,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          color: Color.fromARGB(255, 97, 211, 87),
          disabledColor: Color.fromRGBO(211, 212, 217, 1),
          height: 60,
          onPressed: () async {
            if (await userController.register(
                  username: usernameTextController.text,
                  password: passwordTextController.text,
                  email: emailTextController.text,
                  firstName: firstNameTextController.text,
                  lastName: lastNameTextController.text,
                ) ==
                true) {
              //Leads to login page
              MomentumRouter.goto(
                  context, LoginPage, //RegistrationVerificationPage,
                  transition: (context, page) {
                return MaterialPageRoute(builder: (context) => page);
              });
              //_showSnackbar("SUCCESS!");
              print('Success');
              return;
            } else {
              //_showSnackbar("FAIL!");
              print('Fail');
            }
          },
          child: Row(
            children: <Widget>[
              Expanded(
                child: Text(
                  "Register",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
              Icon(Icons.login_outlined, color: Colors.white),
            ],
          ),
        ),
      ),
    );

    //Snack bar definition
    snackbarWidget = SnackBar(
        key: Key('register_snackbar'),
        content: Text(snackbarMsg),
        backgroundColor: Colors.red, //Color.fromARGB(255, 97, 211, 87),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(
            color: Colors.black,
            width: 2,
          ),
        ));

    Widget child = Form(
      child: SingleChildScrollView(
        padding: const EdgeInsets.only(
          top: 30,
          left: 30,
        ),
        child: Column(
          children: [
            _pageTitle,
            _usernameField,
            _firstNameField,
            _lastNameField,
            _emailField,
            _passwordField,
            _regButton,
          ],
        ),
      ),
    );
    /////////////////////////////  VIEW RETURNED  ////////////////////////////////
    //return view
    return MomentumBuilder(
        controllers: [UserController],
        builder: (context, snapshot) {
          return MobilePageLayout(
            false,
            false,
            child,
            'Registration',
          );
        });
    ////////////////////////////////////////////////////////////////////////////
  }
}
