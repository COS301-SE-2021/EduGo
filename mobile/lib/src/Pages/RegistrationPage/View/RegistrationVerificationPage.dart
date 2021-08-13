import 'package:flutter/material.dart';

//Imported custom components, pages and packages
import 'package:mobile/src/Components/mobile_page_layout.dart';
import 'package:mobile/src/Components/User/Controller/UserController.dart';
import 'package:mobile/src/Pages/RegistrationPage/View/RegistrationPage.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:momentum/momentum.dart';

//This page is used to verify if student is already allocated to an
//organization by an educator
class RegistrationVerificationPage extends StatefulWidget {
  RegistrationVerificationPage(this.key) : super(key: key);
  static String id = "registration_verification";
  Key key = Key('registration_verification');
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
    void _submitForm() async {
      if (await userController.verify(
              email: email_text_controller.text,
              code: code_text_controller.text) ==
          true) {
        // Leads to home page
        MomentumRouter.goto(context, RegistrationPage,
            transition: (context, page) {
          return MaterialPageRoute(builder: (context) => page);
        });
        return;
      }
      // Unsuccessful login: clear fields and display error
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
    //Page title: User Registration
    Widget registration_heading_widget = Text(
      "Registration",
      key: Key('rv_registration_heading'),
      style: const TextStyle(
          fontWeight: FontWeight.bold, color: Colors.black, fontSize: 24),
      textDirection: TextDirection.ltr,
    );

    Widget verification_heading_widget = Text(
      "Verification",
      key: Key('rv_verification_heading'),
      style: const TextStyle(
          fontWeight: FontWeight.bold, color: Colors.black, fontSize: 24),
      textDirection: TextDirection.ltr,
    );

    Widget email_input_widget = FractionallySizedBox(
      widthFactor: 0.8,
      alignment: Alignment.center,
      child: Padding(
        padding: const EdgeInsets.only(
          top: 30,
          left: 30,
        ), //Email input field
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
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: "Email",
            suffixIcon: Icon(Icons.email),
          ),
        ),
      ),
    );

    Widget code_input_widget = FractionallySizedBox(
      widthFactor: 0.8,
      alignment: Alignment.center,
      child: Padding(
        padding: const EdgeInsets.only(
          top: 30,
          left: 30,
        ),
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
              border: OutlineInputBorder(),
              hintText: "Activation Code",
              suffixIcon: Icon(Icons.filter_5_rounded)),
        ),
      ),
    );

    Widget next_button_widget = //Next button that leads to Registration Page
        FractionallySizedBox(
      widthFactor: 0.8,
      alignment: Alignment.center,
      child: Padding(
        key: Key('next_button'),
        padding: const EdgeInsets.only(
          top: 30,
          left: 30,
        ),
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
                    registration_heading_widget,
                    verification_heading_widget,
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
          }),
      "Verification",
    );
    ////////////////////////////////////////////////////////////////////////////
  }
}
