import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:mobile/src/Components/User/Controller/UserController.dart';
import 'package:mobile/src/Pages/HomePage/View/HomePage.dart';
import 'package:mobile/src/Pages/RegistrationPage/View/RegistrationPage.dart';
import 'package:mobile/src/Pages/RegistrationPage/View/RegistrationVerificationPage.dart';
import 'package:momentum/momentum.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);
  final key = Key('login_page');
  static String id = 'login';

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  /////////////////////////  VARIABLES & FUNCTIONS  ////////////////////////////
  //Global key that is going to tell us about any change in Form() widget.
  GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();
  //Scaffold of login page
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  // Text controllers used to retrieve the current value of the input fields
  final username_text_controller = TextEditingController();
  final password_text_controller = TextEditingController();

  late SnackBar error_snackbar;

  void _submitForm(userController) {
    bool mock_login = false;
    if (username_text_controller.text == 'Simekani' &&
        password_text_controller.text == 'Simekani@1') {
      mock_login = true;
    }

    if (
        //userController.login(
        //        username: username_text_controller.text,
        //        password: password_text_controller.text) ==
        mock_login == true) {
      //Leads to home page
      MomentumRouter.goto(context, HomePage, transition: (context, page) {
        return MaterialPageRoute(builder: (context) => page);
      });
      return;
    }
    _clearInputFields();
    _showSnackbar('Unverified');
  }

  void _clearInputFields() {
    username_text_controller.clear();
    password_text_controller.clear();
  }

  //snackbar to show error messages
  void _showSnackbar(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(error_snackbar);
  }

  @override
  void dispose() {
    // Clean up the controllers when the widget is disposed.
    username_text_controller.dispose();
    password_text_controller.dispose();
    super.dispose();
  }
  //////////////////////////////////////////////////////////////////////////////

  @override
  Widget build(BuildContext context) {
    //Get a specific controller (UserController) to call needed functions (login)
    UserController userController =
        Momentum.controller<UserController>(context);

    //////////////////////////////////  WIDGETS  /////////////////////////////////
    //These may include the following widgets: input fields, buttons, forms

    Widget login_user_heading = new Text(
      'User',
      key: Key('login_user_heading'),
      textDirection: TextDirection.ltr,
      style: const TextStyle(
          fontWeight: FontWeight.bold, color: Colors.black, fontSize: 60),
    );

    Widget login_login_heading = new Text(
      'Login',
      key: Key('login_login_heading'),
      textDirection: TextDirection.ltr,
      style: const TextStyle(
          fontWeight: FontWeight.bold, color: Colors.black, fontSize: 60),
    );

    Widget username_input_widget = Padding(
      padding: const EdgeInsets.only(
        top: 60,
        left: 20,
        right: 20,
      ),
      //username input field
      child: new TextFormField(
        key: Key('login_username'),
        //Controller is notified when the text changes
        controller: username_text_controller,
        //Control when the auto validation should happen
        autovalidateMode: AutovalidateMode.always,
        //username is required
        validator: MultiValidator([
          RequiredValidator(errorText: "* Required"),
        ]),
        //type of keyboard to use for editing the text.
        //keyboardType: TextInputType.name,
        //Input field UI
        style: TextStyle(),
        decoration:
            InputDecoration(border: OutlineInputBorder(), hintText: "Username"),
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
      padding: const EdgeInsets.only(
        top: 30,
        left: 20,
        right: 20,
      ),
      child: MaterialButton(
        onPressed: () => _submitForm(userController),
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

    Widget padding_widget = Padding(padding: const EdgeInsets.only(top: 50));

    error_snackbar = SnackBar(
        key: Key('login_snackbar'),
        content: Text('Unverified'),
        backgroundColor: Colors.red, //Color.fromARGB(255, 97, 211, 87),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(
            color: Colors.black,
            width: 2,
          ),
        ),
        action: SnackBarAction(
          label: 'Verify registration.',
          onPressed: () =>
              //Leads to registration verification page
              MomentumRouter.goto(
                  context, RegistrationPage /*RegistrationVerificationPage*/,
                  transition: (context, page) {
            return MaterialPageRoute(builder: (context) => page);
          }),
          //disabledTextColor: Colors.yellow,
          textColor: Colors.white,
        ));
    Widget child = Scaffold(
        body: Form(
            key: _scaffoldKey,
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
                            top: 30,
                          ),
                          child: Column(
                            textDirection: TextDirection.ltr,
                            children: [
                              login_user_heading,
                              login_login_heading,
                              username_input_widget,
                              password_input_widget,
                              login_button_widget,
                              padding_widget,
                            ],
                          ))))
            ])));
    //////////////////////////////////////////////////////////////////////////////

    /////////////////////////////  VIEW RETURNED  //////////////////////////////
    //return view
    return MomentumBuilder(
        controllers: [UserController],
        builder: (context, snapshot) {
          return child;
        });
    ////////////////////////////////////////////////////////////////////////////
  }
}
