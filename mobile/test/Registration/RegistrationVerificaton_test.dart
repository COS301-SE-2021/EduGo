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
  List<TextField> input_fields = [];
  var code_input_field;

  // Widget tests that test each widget's response to user interaction.
  test_email();
  test_code();

  /*
  testWidgets(
      'Successfully find all input fields on page and add to list for future tests',
      (WidgetTester tester) async {
    //find all text fields in on the page
    find.byType(TextField).evaluate().toList().forEach((element) {
      input_fields.add(element.widget as TextField);
    });
    expect(input_fields.length, 2);
    expect(find.byType(TextField), findsNWidgets(2));
  });

  testWidgets('Successfully find email input field',
      (WidgetTester tester) async {
    //find all email input field on the page
    email_input_field = find.byKey(Key('email_input_field'));
    print("output" + email_input_field);
    //expect(email_input_field, findsOneWidget);
  });

  testWidgets('Successfully find activation code input field',
      (WidgetTester tester) async {
    //find all activation code input field on the page
    code_input_field = find.byKey(Key('code_input_field'));
    expect(code_input_field, findsOneWidget);
  });

  testWidgets('Successfully enter text in all input fields on page',
      (WidgetTester tester) async {
    //find all text fields in on the page
    find.byType(TextField).evaluate().toList().forEach((element) {
      input_fields.add(element.widget as TextField);
    });
  });
  */
}

void test_email() {
  group('Email', () {
    //Key used to identify TextFormField widget
    Key _email_input_field = Key('email_input_field');
    testWidgets(
        'should be invalid (missing the "@" symbol) and return an error string',
        (WidgetTester tester) async {
      await tester.pumpWidget(MyApp());
      var result = EmailValidator(errorText: "Invalid email address").errorText;
      expect(result, "Invalid email address");
    });
    test('should be empty and return an error string', () {
      var result = RequiredValidator(errorText: "* Required").errorText;
      expect(result, "* Required");
    });
    test('should be invalid and return an error string', () {
      var result = RequiredValidator(errorText: "* Required").errorText;
      expect(result, "* Required");
    });
  });
}

void test_code() {
  group('Activation code', () {
    test('Empty activation code returns error string', () {
      var result = RequiredValidator(errorText: "* Required").errorText;
      expect(result, "* Required");
    });
    test(
        'Activation code that does not consist of numercs only returns error string',
        () {
      var result =
          PatternValidator("[0-9]{5}", errorText: "Invalid Activation Code")
              .errorText;
      expect(result, "Invalid Activation Code");
    });
    test('Invalid activation code length returns error string', () {
      var result = LengthRangeValidator(
              min: 5, max: 5, errorText: "Invalid Activation Code")
          .errorText;
      expect(result, "Invalid Activation Code");
    });
  });
}


//TODO test error messages: https://stackoverflow.com/questions/58419336/in-a-flutter-widget-test-how-can-i-verify-a-field-validation-error-message
//TODO redo group tests
// https://stackoverflow.com/questions/58419336/in-a-flutter-widget-test-how-can-i-verify-a-field-validation-error-message
//https://github.com/flutter/flutter/blob/master/packages/flutter/test/widgets/form_test.dart
      /*testWidgets('Successfully enter text into input field',
      (WidgetTester tester) async {
    
    // Build the widget
    await tester.pumpWidget(RegistrationVerificationPage());
    //Tap TextFormField
    await tester.tap(email_input_field);
    // Enter email into the TextFormField.
    await tester.enterText(email_input_field, 'sthe@gmail.com');
    //Test result
    expect(find.text('sthe@gmail.com'), findsOneWidget);
  });*/
