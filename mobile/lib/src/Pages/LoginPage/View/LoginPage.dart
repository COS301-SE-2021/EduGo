import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:momentum/momentum.dart';
import 'package:mobile/src/Components/User/Controller/UserController.dart';
import 'package:mobile/src/Pages/HomePage/View/HomePage.dart';
import 'package:mobile/src/Pages/RegistrationPage/View/RegistrationPage.dart';
import 'package:mobile/src/Pages/RegistrationPage/View/RegistrationVerificationPage.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);
  final key = Key('login_page');
  static String id = 'login';

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  /////////////////////////  VARIABLES & FUNCTIONS  ////////////////////////////
  // Unique key that identifies page: https://iiro.dev/writing-widget-tests-for-navigation-events/
  static const navigateToVerificationLinkKey =
      Key('navigateToVerificationLinkKey');
  // Global key that is going to tell us about any change in Form() widget.
  GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();

  // Key of scaffold of login page
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  // Text controllers used to retrieve the current value of the input fields
  final username_text_controller = TextEditingController();
  final password_text_controller = TextEditingController();

  //Snackbar widget that displays login error
  late SnackBar error_snackbar;

  // Function called when login button pressed
  void _submitForm(userController) async {
    if (await userController.login(
            username: username_text_controller.text,
            password: password_text_controller.text) ==
        true) {
      // Leads to home page
      MomentumRouter.goto(context, HomePage, transition: (context, page) {
        return MaterialPageRoute(builder: (context) => page);
      });
      return;
    }
    // Unsuccessful login: clear fields and display error
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

    /*
    Widget loginImage (int height, int width) = Container(
        alignment: Alignment.center,
        height: height * 0.45,
        widthFactor: 0.9,
        child: Image.asset(
          'assets/login_image',
          fit: BoxFit.fill,
        ));
    */

    Widget loginUserHeading = new Text(
      'User',
      key: Key('loginUserHeading'),
      textDirection: TextDirection.ltr,
      style: const TextStyle(
          fontWeight: FontWeight.bold, color: Colors.black, fontSize: 25),
    );

    Widget loginLoginHeading = new Text(
      'Login',
      key: Key('loginLoginHeading'),
      textDirection: TextDirection.ltr,
      style: const TextStyle(
          fontWeight: FontWeight.bold, color: Colors.black, fontSize: 25),
    );

    Widget usernameInputWidget = Padding(
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
          LengthRangeValidator(min: 8, max: 20, errorText: 'Invalid username')
        ]),
        //type of keyboard to use for editing the text.
        //keyboardType: TextInputType.name,
        //Input field UI
        style: TextStyle(),
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          hintText: "Username",
          suffixIcon: Icon(Icons.person),
        ),
      ),
    );

    Widget passwordInputWidget = Padding(
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
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          hintText: "Password",
          suffixIcon: Icon(Icons.visibility_off),
        ),
      ),
    );

    Widget registerWidget = GestureDetector(
      key: navigateToVerificationLinkKey,
      onTap: () {
        //Leads to registration verification page
        MomentumRouter.goto(context, RegistrationVerificationPage,
            transition: (context, page) {
          return MaterialPageRoute(builder: (context) => page);
        });
      },
      child: Text.rich(
        TextSpan(text: 'Can\'t log in yet: ', children: [
          TextSpan(
            text: 'Verify Registration',
            style: TextStyle(color: Colors.blue),
          ),
        ]),
      ),
    );

    Widget loginButtonWidget = Padding(
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

    Widget paddingWidget = Padding(padding: const EdgeInsets.only(top: 50));

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
              MomentumRouter.goto(context, RegistrationVerificationPage,
                  transition: (context, page) {
            return MaterialPageRoute(builder: (context) => page);
          }),
          textColor: Colors.blue,
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
                            mainAxisAlignment: MainAxisAlignment.center,
                            textDirection: TextDirection.ltr,
                            children: [
                              //loginImage,
                              loginUserHeading,
                              loginLoginHeading,
                              usernameInputWidget,
                              passwordInputWidget,
                              loginButtonWidget,
                              paddingWidget,
                              registerWidget,
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
