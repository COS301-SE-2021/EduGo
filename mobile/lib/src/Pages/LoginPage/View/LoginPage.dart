import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:mobile/src/Components/Common/ValidationClasses.dart';
import 'package:mobile/src/Pages/LessonsPage/View/LessonsPage.dart';
import 'package:mobile/src/Pages/SubjectsPage/View/SubjectsPage.dart';
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
      // Leads to subjects page
      MomentumRouter.goto(context, SubjectsPage, transition: (context, page) {
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

    //HEADING of the page: User Login
    Widget loginUserHeading = new Text(
      'User',
      key: Key('loginUserHeading'),
      textDirection: TextDirection.ltr,
      style: TextStyle(
          fontSize: 35, color: Colors.black, fontWeight: FontWeight.normal),
    );

    Widget loginLoginHeading = new Text(
      'Login',
      key: Key('loginLoginHeading'),
      textDirection: TextDirection.ltr,
      style: TextStyle(
          fontSize: 35,
          color: Color.fromARGB(255, 97, 211, 87),
          fontWeight: FontWeight.bold),
    );

    // Username input field
    Widget usernameInputWidget = FractionallySizedBox(
      widthFactor: 0.8,
      alignment: Alignment.center,
      child: Padding(
        padding: const EdgeInsets.only(
          top: 30,
        ),
        //username input field
        child: new TextFormField(
          key: Key('login_username'),
          //Controller is notified when the text changes
          controller: username_text_controller,
          //Control when the auto validation should happen
          autovalidateMode: AutovalidateMode.always,
          //username is required
          validator: //UsernameFieldValidator.validate,
              MultiValidator([
            RequiredValidator(errorText: "* Required"),
            LengthRangeValidator(min: 4, max: 20, errorText: 'Invalid username')
          ]),
          //type of keyboard to use for editing the text.
          //keyboardType: TextInputType.name,
          //Input field UI
          style: TextStyle(),
          decoration: InputDecoration(
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                  color: Color.fromARGB(255, 97, 211, 87), width: 2.0),
            ),
            border: OutlineInputBorder(),
            hintStyle: TextStyle(fontSize: 15),
            hintText: "Username",
            suffixIcon: Icon(Icons.person),
          ),
        ),
      ),
    );

    Widget passwordInputWidget = FractionallySizedBox(
      widthFactor: 0.8,
      alignment: Alignment.center,
      child: Padding(
        padding: const EdgeInsets.only(
          top: 30,
        ),
        //password input field
        child: TextFormField(
          key: Key('login_password'),
          //Controller is notified when the text changes
          controller: password_text_controller,
          obscureText: true,
          //Control when the auto validation should happen
          autovalidateMode: AutovalidateMode.always,
          //password is required, must be 6 digits long and must be numeric
          validator: //PasswordFieldValidator.validate,
              MultiValidator([
            RequiredValidator(errorText: "* Required"),
            MinLengthValidator(8, errorText: "Invalid password"),
            PatternValidator(
                r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$',
                errorText: "Invalid password"),
          ]),
          //type of keyboard to use for editing the text.
          //keyboardType: TextInputType.,
          //Input field UI
          style: TextStyle(),
          decoration: InputDecoration(
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                  color: Color.fromARGB(255, 97, 211, 87), width: 2.0),
            ),
            border: OutlineInputBorder(),
            hintStyle: TextStyle(fontSize: 15),
            hintText: "Password",
            suffixIcon: Icon(Icons.visibility_off),
          ),
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
            style: TextStyle(
                color: Colors.blue, decoration: TextDecoration.underline),
          ),
        ]),
      ),
    );

    Widget loginButtonWidget = FractionallySizedBox(
      widthFactor: 0.7,
      alignment: Alignment.centerRight,
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
          onPressed: () => _submitForm(userController),
          height: 60,
          color: Color.fromARGB(255, 97, 211, 87),
          disabledColor: Color.fromRGBO(211, 212, 217, 1),
          child: Row(
            children: <Widget>[
              Expanded(
                child: Text(
                  "Login",
                  style: TextStyle(color: Colors.white, fontSize: 15),
                ),
              ),
              Icon(Icons.login_outlined, color: Colors.white),
            ],
          ),
        ),
      ),
    );

    Widget paddingWidget = Padding(padding: const EdgeInsets.only(top: 25));

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
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [
              Color.fromRGBO(20, 195, 50, 1.0),
              Color.fromRGBO(11, 36, 54, 1.0)
            ],
          ),
        ),
        child: Form(
          key: _scaffoldKey,
          child: Stack(key: Key('login_form'), children: <Widget>[
            //to see te underlying green color
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 50.0, horizontal: 25.0),
              child: Material(
                elevation: 40,
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.only(top: 50),
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.only(
                        top: 30,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        textDirection: TextDirection.ltr,
                        children: [
                          loginUserHeading,
                          loginLoginHeading,
                          paddingWidget,
                          usernameInputWidget,
                          passwordInputWidget,
                          loginButtonWidget,
                          registerWidget,
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
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
