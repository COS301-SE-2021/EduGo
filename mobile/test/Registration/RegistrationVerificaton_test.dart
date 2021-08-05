//{"email":"", "verificationCode": "16536"}
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:mobile/src/Pages/RegistrationPage/View/RegistrationVerificationPage.dart';

//Automated tests help guarantee that your application performs accurately before you publish it while holding your feature and bug-fix velocity
//utilize the WidgetTester utility for various things while testing, for example, sending input to a widget, finding a part in the widget tree, confirming values, etc.
void main() {
  List<TextField> input_fields = [];
  var email_input_field;
  var code_input_field;

  // Define widget tests that test each widget's response to user interaction.
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
  //TODO validator tests
  test('Invalid email returns error string', () {
    var result = EmailValidator(errorText: "Invalid email address").errorText;
    expect(result, "Invalid email address");
  });
  test('Empty email returns error string', () {
    var result = RequiredValidator(errorText: "* Required").errorText;
    expect(result, "* Required");
  });
//TODO test error messages: https://stackoverflow.com/questions/58419336/in-a-flutter-widget-test-how-can-i-verify-a-field-validation-error-message
//TODO group tests

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
}

/* 


    formFields.forEach((element) {
      expect(element.maxLines, 1);

      switch (element.decoration.hintText) {
        case 'First name':
          expect(element.maxLength, 50);
          break;

        case 'Last name':
          expect(element.maxLength, 25);
          break;
      }
    });
  });
  */
