//{"email":"", "verificationCode": "16536"}
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:mobile/main.dart';
import 'package:mobile/src/Pages/RegistrationPage/View/RegistrationVerificationPage.dart';

//Automated tests help guarantee that your application performs accurately before you publish it while holding your feature and bug-fix velocity
//utilize the WidgetTester utility for various things while testing, for example, sending input to a widget, finding a part in the widget tree, confirming values, etc.
void main() {
  //NUMBER OF TESTS SO FAR: 5
  //implement error test.
  //implement norm

//TODO Implement widget tests
  _widget_tests();

//TODO Implement unit tests
  _unit_tests();

//TODO Implement integration tests
  _integration_tests();
}

///////////////////////////// WIDGET TESTS /////////////////////////////////////
void _widget_tests() {
  //TODO implement test
  group('Text', () {
    //testWidgets('should render successfully.', (WidgetTester tester) async {});
  }); //group Text
  //TODO implement test
  group('Email', () {}); //group Email
  //TODO implement test
  group('Activation code', () {}); //group Activation code
  //TODO implement test
  group('Next button', () {}); //group Next button
  //TODO implement test
  group('Snackbar', () {}); //group Snackbar
}
////////////////////////////////////////////////////////////////////////////////

/////////////////////////////// UNIT TESTS /////////////////////////////////////
void _unit_tests() {}
////////////////////////////////////////////////////////////////////////////////

/////////////////////////// INTEGRATION TESTS //////////////////////////////////
void _integration_tests() {}
////////////////////////////////////////////////////////////////////////////////

//TODO test error messages: https://stackoverflow.com/questions/58419336/in-a-flutter-widget-test-how-can-i-verify-a-field-validation-error-message
//TODO redo group tests
// https://stackoverflow.com/questions/58419336/in-a-flutter-widget-test-how-can-i-verify-a-field-validation-error-message
//https://github.com/flutter/flutter/blob/master/packages/flutter/test/widgets/form_test.dart
/*testWidgets('Successfully enter text into input field',
      (WidgetTester tester) async {
*/
