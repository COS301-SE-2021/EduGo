//{"email":"", "verificationCode": "16536"}
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:mobile/main.dart';
import 'package:mobile/src/Components/User/Controller/UserController.dart';
import 'package:mobile/src/Pages/RegistrationPage/View/RegistrationVerificationPage.dart';
import 'package:momentum/momentum.dart';

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

//testWidgets('successfully.', (WidgetTester tester) async {});
///////////////////////////// WIDGET TESTS /////////////////////////////////////
void _widget_tests() {
  group('Text', () {
    testWidgets('form fields should render successfully.',
        (WidgetTester tester) async {
      final widget = Momentum(
          child: MaterialApp(
            home:
                RegistrationVerificationPage(Key('registration_verification')),
          ),
          controllers: [
            UserController(),
          ]);
      await tester.pumpWidget(widget);
      await tester.pumpAndSettle();

      // Find text form fields
      final textFieldFinder = find.byType(TextFormField);
      // Expect 2 rendered text form fields
      expect(textFieldFinder, findsNWidgets(2));
    });
    testWidgets('form fields should be empty and display an error string.',
        (WidgetTester tester) async {
      final widget = Momentum(
          child: MaterialApp(
            home:
                RegistrationVerificationPage(Key('registration_verification')),
          ),
          controllers: [
            UserController(),
          ]);
      await tester.pumpWidget(widget);
      await tester.pumpAndSettle();

      // find empty text
      final textFinder = find.text('');
      // Find error message
      final textErrorFinder = find.text('* Required');
      // Expect 2 empty text form fields
      expect(textFinder, findsNWidgets(2));
      // Expect 2 error messages, one for each empty text form fields
      expect(textErrorFinder, findsNWidgets(2));
    });

    testWidgets('headings for page should render successfully.',
        (WidgetTester tester) async {
      final widget = Momentum(
          child: MaterialApp(
            home:
                RegistrationVerificationPage(Key('registration_verification')),
          ),
          controllers: [
            UserController(),
          ]);
      await tester.pumpWidget(widget);
      await tester.pumpAndSettle();

      // find "Registration" text
      final regHeadingFinder = find.byKey(Key('rv_registration_heading'));
      // find "Verification" text
      final verHeadingFinder = find.byKey(Key('rv_verification_heading'));
      // Expect to find headings
      expect(regHeadingFinder, findsOneWidget);
      expect(verHeadingFinder, findsOneWidget);
    });
  }); //group Text
  //TODO implement test
  group('Email', () {
    testWidgets('form field should render successfully.',
        (WidgetTester tester) async {
      final widget = Momentum(
          child: MaterialApp(
            home:
                RegistrationVerificationPage(Key('registration_verification')),
          ),
          controllers: [
            UserController(),
          ]);
      await tester.pumpWidget(widget);
      await tester.pumpAndSettle();

      // Find text form fields
      final textFieldFinder = find.byKey(Key('email_input_field'));
      // Expect 1 rendered text form field
      expect(textFieldFinder, findsOneWidget);
    });
    testWidgets('form field should be empty and display an error string.',
        (WidgetTester tester) async {
      final widget = Momentum(
          child: MaterialApp(
            home:
                RegistrationVerificationPage(Key('registration_verification')),
          ),
          controllers: [
            UserController(),
          ]);
      await tester.pumpWidget(widget);
      await tester.pumpAndSettle();

      // find activaton code text form field
      final codeFieldFinder = find.byKey(Key('code_input_field'));
      //Attach keyboard to acquire focus
      await tester.showKeyboard(codeFieldFinder);
      //enter invalid text
      await tester.enterText(codeFieldFinder, 'invalid code');
      // find empty text
      //final textFinder = find.text('Invalid Activation Code');
      // Find error message
      final textErrorFinder = find.text('* Required');
      // Expect 1 empty text form fields
      //expect(textFinder, findsOneWidget);
      // Expect 1 error messages, one for each empty text form fields
      expect(textErrorFinder, findsOneWidget);
    });

    /*testWidgets('form field should be empty and display an error string.',
        (WidgetTester tester) async {
      final widget = Momentum(
          child: MaterialApp(
            home:
                RegistrationVerificationPage(Key('registration_verification')),
          ),
          controllers: [
            UserController(),
          ]);
      await tester.pumpWidget(widget);
      await tester.pumpAndSettle();

      // find activaton code text form field
      final codeFieldFinder = find.byKey(Key('code_input_field'));
      //Attach keyboard to acquire focus
      await tester.showKeyboard(codeFieldFinder);
      //enter invalid text
      await tester.enterText(codeFieldFinder, 'invalid code');
      // find empty text
      final textFinder = find.text('Invalid Activation Code');
      // Find error message
      final textErrorFinder = find.text('* Required');
      // Expect 1 empty text form fields
      expect(textFinder, findsOneWidget);
      // Expect 1 error messages, one for each empty text form fields
      expect(textErrorFinder, findsOneWidget);
    });*/
  }); //group Email
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
