//https://pub.dev/packages/reactive_forms
import 'package:flutter/material.dart';
import 'package:mobile/src/Components/mobile_page_layout.dart';
import 'package:mobile/src/Pages/HomePage/View/HomePage.dart';

class RegistrationPage extends StatefulWidget {
  RegistrationPage();
  static String id = "registration";
// RegistrationModel(this.password, this.user_firstName, this.user_lastName,
// this.user_email, this.organisation_id, this.userType, this.username);

  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

/* 

*/
class _RegistrationPageState extends State<RegistrationPage> {
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

//User Type
//Username
  @override
  Widget build(BuildContext context) {
    Widget child = SingleChildScrollView(
      child: Column(
        children: [
          //Page Title: User Registration
          Text(
            "User",
            style: const TextStyle(
                fontWeight: FontWeight.bold, color: Colors.black, fontSize: 60),
          ),
          Text("Registration",
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 60)),
          //UserType input field
          DropdownButtonFormField<String>(
            value: selected_user_type,
            icon: const Icon(Icons.arrow_downward),
            iconSize: 24,
            elevation: 16,
            style: const TextStyle(color: Colors.black),
            //TODO controller MVC state change?
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
          ),
          //TODO getOrganisations
          //Organisations input field
          DropdownButtonFormField<String>(
            value: selected_organisation,
            icon: const Icon(Icons.arrow_downward),
            iconSize: 24,
            elevation: 16,
            style: const TextStyle(color: Colors.black),
            //TODO controller MVC state change?
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
          ),
          //Username input field
          Padding(
            padding: const EdgeInsets.only(top: 30),
            child: TextField(
              style: TextStyle(),
              decoration: InputDecoration(
                  border: OutlineInputBorder(), hintText: "Username"),
            ),
          ),
          //First Name input field
          Padding(
            padding: const EdgeInsets.only(top: 30),
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

          //Register button
          Padding(
            padding: const EdgeInsets.only(
              top: 30,
              bottom: 30,
            ),
            child: MaterialButton(
              onPressed: () {
                //Leads to home page
                Navigator.pushNamed(context, HomePage.id);
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
          ),
        ],
      ),
    );
    //Containerization of page
    return MobilePageLayout(false, false, child);
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
