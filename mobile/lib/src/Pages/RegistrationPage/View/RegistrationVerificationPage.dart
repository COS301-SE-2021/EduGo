import 'package:flutter/material.dart';

//Imported custom components, pages and packages
import 'package:mobile/src/Components/mobile_page_layout.dart';
import 'package:mobile/src/Components/User/Controller/UserController.dart';
import 'package:mobile/src/Components/User/Models/UserModel.dart';
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
    UserController userController = Momentum.of<UserController>(context);

    // "Next" button is disabled until the user completes the form
    bool _isButtonEnabled = false;

    //When the form is submitted
    void _submitForm() {
      if (userController.verify(
              email: email_text_controller.text,
              code: code_text_controller.text) ==
          true) {
        //Leads to home page
        Navigator.pushNamed(context, RegistrationPage.id);
      } else {
        print("unsuccessful");
        clearTextInput();
      }
    }
    ////////////////////////////////////////////////////////////////////////////

    ////////////////////////////////  WIDGETS  /////////////////////////////////
    //These may include the following widgets: input fields, buttons, forms
    Widget email_input_widget = Padding(
      padding: const EdgeInsets.only(top: 100),
      //Email input field
      child: TextFormField(
        //Controller is notified when the text changes
        controller: email_text_controller,
        //Control when the auto validation should happen
        //autovalidateMode: AutovalidateMode.always,
        //Email is required and must be valid
        validator: MultiValidator([
          RequiredValidator(errorText: "* Required"),
          EmailValidator(errorText: "Invalid email address"),
        ]),
        //Input field UI
        style: TextStyle(),
        decoration:
            InputDecoration(border: OutlineInputBorder(), hintText: "Email"),
      ),
    );

    Widget code_input_widget = //Code input field
        Padding(
      padding: const EdgeInsets.only(top: 30),
      //Code input field
      child: TextFormField(
        //Controller is notified when the text changes
        controller: code_text_controller,
        //Control when the auto validation should happen
        //autovalidateMode: AutovalidateMode.always,
        //Code is required, must be 6 digits long and must be numeric
        validator: MultiValidator([
          RequiredValidator(errorText: "* Required"),
          LengthRangeValidator(
              min: 6, max: 6, errorText: "Invalid Activation Code"),
          PatternValidator("[0-9]{6}",
              errorText: "Invalid Activation Code"), //Digits only
        ]),
        //Input field UI
        style: TextStyle(),
        decoration: InputDecoration(
            border: OutlineInputBorder(), hintText: "Activation Code"),
      ),
    );

    Widget next_button_widget = //Next button that leads to Registration Page
        Padding(
      padding: const EdgeInsets.only(top: 50),
      child: MaterialButton(
        onPressed: _isButtonEnabled ? () => _submitForm() : null,
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
      onChanged: () =>
          //enable or disable button depending on whether or not all input fieldshave been filled in
          setState(
        () => _isButtonEnabled = _formkey.currentState!.validate(),
      ),
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
              var user = snapshot<UserModel>();
              return child;
            }));
    ////////////////////////////////////////////////////////////////////////////
  }
}
