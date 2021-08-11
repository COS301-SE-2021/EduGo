//https://pub.dev/packages/reactive_forms
import 'package:flutter/material.dart';
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
  String selected_organisation = 'Select an organisation';
  final List<String> organisations = <String>[
    'Select an organisation',
    'UP',
    'WITS',
    'UCT'
  ];

  String selected_user_type = 'Select a user type';
  final List<String> user_types = <String>[
    'Select a user type',
    'educator',
    'student'
  ];

  // lastName: lastName, organisation_id: organisation_id, type: type))

  // Text controllers used to retrieve the current value of the input fields
  final usernameTextController = TextEditingController();
  final passwordTextController = TextEditingController();
  final emailTextController = TextEditingController();
  final firstNameTextController = TextEditingController();
  final lastNameTextController = TextEditingController();
  final orgIdTextController = TextEditingController();
  final userTypeTextController = TextEditingController();

  // @override
  // void initState() {
  //   super.initState();
  //   selected_organisation = 'Select an organisation';
  // }

  @override
  void dispose() {
    // Clean up the controllers when the widget is disposed.
    usernameTextController.dispose();
    passwordTextController.dispose();
    emailTextController.dispose();
    firstNameTextController.dispose();
    lastNameTextController.dispose();
    orgIdTextController.dispose();
    userTypeTextController.dispose();
    super.dispose();
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

    //UserType input field
    Widget _userTypeField = DropdownButtonFormField<String>(
      value: selected_user_type,
      icon: const Icon(
        Icons.arrow_downward,
        key: Key('userTypeIcon'),
      ),
      iconSize: 24,
      elevation: 16,
      style: const TextStyle(color: Colors.black),
      onChanged: (String? newValue) {
        setState(() {
          selected_user_type = newValue!;
        });
      },
      onSaved: (String? newValue) {
        setState(() {
          selected_user_type = newValue!;
        });
      },
      items: user_types.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );

    //Organisations input
    Widget _orgTypeField = DropdownButtonFormField<String>(
      value: selected_organisation,
      icon: const Icon(
        Icons.arrow_downward,
        key: Key('orgTypeIcon'),
      ),
      iconSize: 24,
      elevation: 16,
      style: const TextStyle(color: Colors.black),
      onChanged: (String? newValue) {
        setState(() {
          selected_organisation = newValue!;
        });
      },
      onSaved: (String? newValue) {
        setState(() {
          selected_organisation = newValue!;
        });
      },
      items: organisations.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );

    //Username input field
    Widget _usernameField = Padding(
      padding: const EdgeInsets.only(top: 30),
      child: TextField(
        style: TextStyle(),
        decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: "Username",
            prefixIcon: Icon(Icons.person)),
      ),
    );
    //First Name input field
    Widget _firstNameField = Padding(
      padding: const EdgeInsets.only(top: 30),
      child: TextField(
        style: TextStyle(),
        decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: "First Name",
            prefixIcon: Icon(Icons.person_add)),
      ),
    );
    //Last Name input field
    Widget _lastNameField = Padding(
      padding: const EdgeInsets.only(top: 30),
      child: TextField(
        style: TextStyle(),
        decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: "Last Name",
            prefixIcon: Icon(Icons.person_add_alt_1)),
      ),
    );
    //Email input field
    Widget _emailField = Padding(
      padding: const EdgeInsets.only(top: 30),
      child: TextField(
        style: TextStyle(),
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          hintText: "Email",
          prefixIcon: Icon(Icons.email_outlined),
        ),
      ),
    );

    //Register button
    Widget _regButton = Padding(
      padding: const EdgeInsets.only(
        top: 30,
        bottom: 30,
      ),
      child: MaterialButton(
        onPressed: () async {
          if (await userController.register(
                  username: usernameTextController.text,
                  password: passwordTextController.text,
                  email: emailTextController.text,
                  firstName: firstNameTextController.text,
                  lastName: lastNameTextController.text,
                  organisation_id: orgIdTextController.text,
                  type: userTypeTextController.text) ==
              true) {
            //Leads to login page
            MomentumRouter.goto(
                context, LoginPage, //RegistrationVerificationPage,
                transition: (context, page) {
              return MaterialPageRoute(builder: (context) => page);
            });
          } else {
            usernameTextController.clear();
          }
        },
        height: 60,
        color: Colors.black,
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
    );

    Widget child = SingleChildScrollView(
      child: Column(
        children: [
          //TODO insert logo image
          _pageTitle,
          _userTypeField,
          _orgTypeField,
          _usernameField,
          _firstNameField,
          _lastNameField,
          _emailField,
          _regButton,
        ],
      ),
    );
    /////////////////////////////  VIEW RETURNED  ////////////////////////////////
    //return view
    return MomentumBuilder(
        controllers: [UserController],
        builder: (context, snapshot) {
          return MobilePageLayout(false, false, child);
        });
    ////////////////////////////////////////////////////////////////////////////
  }
}
/*
class RegistrationPage extends StatelessWidget {
  const RegistrationPage();
  static String id = "registration";

  /
//Organisation
//User Type
//Username
  @override
  Widget build(BuildContext context) {
    Widget child = Stack(
      children: [
        //First Name input field
        Padding(
          padding: const EdgeInsets.only(top: 100),
          child: TextField(
            style: TextStyle(),
            decoration: InputDecoration(
                border: OutlineInputBorder(), hintText: "First Name"),
          ),
        ),
        //Last Name input field
        Padding(
          padding: const EdgeInsets.only(top: 30),
          child: TextField(
            style: TextStyle(),
            decoration: InputDecoration(
                border: OutlineInputBorder(), hintText: "Last Name"),
          ),
        ),
        //Email input field
        Padding(
          padding: const EdgeInsets.only(top: 30),
          child: TextField(
            style: TextStyle(),
            decoration: InputDecoration(
                border: OutlineInputBorder(), hintText: "Email"),
          ),
        ),
        //TODO getOrganisations
        //Organisations input field
        DropdownButton<String>(
          value: "Select an organisations",
          icon: const Icon(Icons.arrow_downward),
          iconSize: 24,
          elevation: 16,
          style: const TextStyle(color: Colors.deepPurple),
          underline: Container(
            height: 2,
            color: Colors.deepPurpleAccent,
          ),
          onChanged: (String? newValue) {
            setState(() {
              selectedOrganisation = newValue!;
            });
          },
          organisations: <String>['One', 'Two', 'Free', 'Four']
              .map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        )
      ],
    );
    return MobilePageLayout(true, true, child);
  }
}
*/
