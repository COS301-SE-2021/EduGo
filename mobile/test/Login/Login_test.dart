//this file contains the actual test scripts that we are going to write by using
//tester methods

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile/main.dart';
import 'package:mobile/src/Pages/LoginPage/View/LoginPage.dart';

//TODO update tests to remove email
//TOTAL NUMBER OF TESTS: 33
void main() {
  _widget_tests();

//TODO Implement unit tests
  _unit_tests();

//TODO Implement integration tests
  _integration_tests();
}

void _widget_tests() {
  //"widget testing" https://www.xamantra.dev/momentum/#/testing?id=widget-test
  //tester (single widget unit testing): https://stackoverflow.com/questions/62635696/flutter-widget-vs-flutter-driver
  //"pump()" https://medium.com/flutter/event-loop-in-widget-tester-50b3ca5e9fc5
  //"side bar" https://stackoverflow.com/questions/55628369/flutter-automatic-testing-tap-on-a-button-dont-work-in-drawer
  _test_form_widget();
  _test_text_widget();
  _test_username_widget();
  _test_password_widget();
  _test_login_button_widget();
}

void _unit_tests() {
  //"unit testing controllers, models and services" https://www.xamantra.dev/momentum/#/testing?id=momentumtester https://www.xamantra.dev/momentum/#/momentum-tester
}
void _integration_tests() {
  //user interaction test: https://flutter.dev/docs/cookbook/testing/widget/tap-drag
  //flutter driver (more complex integretion testing): https://medium.com/flutter-community/testing-flutter-ui-with-flutter-driver-c1583681e337
  //_connection_to_driver();
  //_test_email_integration();
}

///////////////////////////// WIDGET TESTS /////////////////////////////////////
void _test_form_widget() {
  //1 test
  group('Form', () {
    testWidgets('should initialise and render successfully.',
        (WidgetTester tester) async {
      //returns an instance of Momentum i.e. the app
      final widget = momentum();
      //builds and renders the provided widget
      await tester.pumpWidget(widget);
      //repeatedly triggers a rebuild of the widget when the state changes.
      await tester.pumpAndSettle();
      // find all input fields
      final formFinder = find.byKey(Key('login_form'));
      //test result: finds both
      expect(formFinder, findsOneWidget);
    });

    testWidgets('input fields should initialise and render successfully.',
        (WidgetTester tester) async {
      //returns an instance of Momentum i.e. the app
      final widget = momentum();
      //builds and renders the provided widget
      await tester.pumpWidget(widget);
      //repeatedly triggers a rebuild of the widget when the state changes.
      await tester.pumpAndSettle();
      // find all input fields
      final fieldFinder = find.byType(TextFormField);
      //test result: finds both
      expect(fieldFinder, findsNWidgets(2));
    });
  });
}

void _test_text_widget() {
  //2 test
  group('Text Form Field inputs ', () {
    testWidgets('should both be empty and return an error string',
        (WidgetTester tester) async {
      // returns an instance of Momentum i.e. the app
      final widget = momentum();
      // builds and renders the provided widget
      await tester.pumpWidget(widget);
      // repeatedly triggers a rebuild of the widget when the state changes.
      await tester.pumpAndSettle();
      // find error message
      final textErrorFinder = find.text('* Required');
      //test result: invalid email error
      expect(textErrorFinder, findsNWidgets(2));
      //TODO check that it's empty
    });

    testWidgets('should both render successfully.',
        (WidgetTester tester) async {
      //returns an instance of Momentum i.e. the app
      final widget = momentum();
      //builds and renders the provided widget
      await tester.pumpWidget(widget);
      //repeatedly triggers a rebuild of the widget when the state changes.
      await tester.pumpAndSettle();
      // find all input fields
      final textInputFinder = find.byType(TextFormField);
      //test result: finds both
      expect(textInputFinder, findsNWidgets(2));
    });
  }); //group
}

void _test_username_widget() {}

void _test_password_widget() {
  group('Password', () {
    testWidgets('input field renders successfully.',
        (WidgetTester tester) async {
      //returns an instance of Momentum i.e. the app
      final widget = momentum();
      //builds and renders the provided widget
      await tester.pumpWidget(widget);
      //repeatedly triggers a rebuild of the widget when the state changes.
      await tester.pumpAndSettle();
      //find password input
      final passowrdInputFinder = find.byKey(Key('login_password'));
      //test result
      expect(passowrdInputFinder, findsOneWidget);
    });

    testWidgets('input field should be empty.', (WidgetTester tester) async {
      // returns an instance of Momentum i.e. the app
      final widget = momentum();
      // builds and renders the provided widget
      await tester.pumpWidget(widget);
      // repeatedly triggers a rebuild of the widget when the state changes.
      await tester.pumpAndSettle();
      //find password input
      final passowrdInputFinder = find.byKey(Key('login_password'));
      // retrieve TextField Widget from Finder
      TextFormField pswdTextField = tester.widget(passowrdInputFinder);
      // test result: confirm TextField is empty
      expect(pswdTextField.controller!.text, equals(""));
    });

    testWidgets(
        'input text form field successfully responds to user interaction: entering text', //is successfully entered into the input text form filed
        (WidgetTester tester) async {
      //returns an instance of Momentum i.e. the app
      final widget = momentum();
      //builds and renders the provided widget
      await tester.pumpWidget(widget);
      //repeatedly triggers a rebuild of the widget when the state changes.
      await tester.pumpAndSettle();
      //find password input
      final passowrdInputFinder = find.byKey(Key('login_password'));
      //Aquire focus in the TextFormField
      await tester.tap(passowrdInputFinder);
      // Enter 'Sshhh' into the TextFormField.
      await tester.enterText(passowrdInputFinder, 'Sshhh');
    });

    testWidgets(' entered in the text form field is displayed successfully',
        (WidgetTester tester) async {
      // returns an instance of Momentum i.e. the app
      final widget = momentum();
      // builds and renders the provided widget
      await tester.pumpWidget(widget);
      // repeatedly triggers a rebuild of the widget when the state changes.
      await tester.pumpAndSettle();
      //find password input
      final passowrdInputFinder = find.byKey(Key('login_password'));
      //Aquire focus in the TextFormField
      await tester.tap(passowrdInputFinder);
      // Enter 'Sshhh' into the TextFormField.
      await tester.enterText(passowrdInputFinder, 'Sshhh');
      // retrieve TextField Widget from Finder
      TextFormField pswdTextField = tester.widget(passowrdInputFinder);
      // test result: confirm TextField is empty
      expect(pswdTextField.controller!.text, equals("Sshhh"));
    });

    testWidgets('input field should be empty and return an error string',
        (WidgetTester tester) async {
      //test the RequiredValidator

      //returns an instance of Momentum i.e. the app
      final widget = momentum();
      //builds and renders the provided widget
      await tester.pumpWidget(widget);
      //repeatedly triggers a rebuild of the widget when the state changes.
      await tester.pumpAndSettle();
      //find password input
      final passowrdInputFinder = find.byKey(Key('login_password'));
      // retrieve TextField Widget from Finder
      TextFormField pswdTextField = tester.widget(passowrdInputFinder);
      // find error message
      final pswdErrorFinder = find.text('* Required');
      // add delay
      await tester.pump(const Duration(milliseconds: 100));
      // test result: confirm TextField is empty
      expect(pswdTextField.controller!.text, equals(""));
      //test result: invalid email error
      expect(pswdErrorFinder, findsWidgets);
    });

    testWidgets(
        'should be invalid (smaller than 8 digits in length) and return an error string',
        (WidgetTester tester) async {
      //test the MinLengthValidator

      //returns an instance of Momentum i.e. the app
      final widget = momentum();
      //builds and renders the provided widget
      await tester.pumpWidget(widget);
      //repeatedly triggers a rebuild of the widget when the state changes.
      await tester.pumpAndSettle();
      //find password input
      final passowrdInputFinder = find.byKey(Key('login_password'));

      //Aquire focus in the TextFormField
      await tester.tap(passowrdInputFinder);
      // Enter '1' into the TextFormField.
      await tester.enterText(passowrdInputFinder, '1');
      // find error message
      var pswdErrorFinder = find.text('Invalid password');
      // add delay
      await tester.pump(const Duration(milliseconds: 100));
      //test result: invalid password as the text in the textfield is now
      //1 characters in length
      expect(pswdErrorFinder, findsOneWidget);

      //Aquire focus in the TextFormField
      await tester.tap(passowrdInputFinder);
      // Enter '12' into the TextFormField.
      await tester.enterText(passowrdInputFinder, '12');
      // find error message
      pswdErrorFinder = find.text('Invalid password');
      // add delay
      await tester.pump(const Duration(milliseconds: 100));
      //test result: invalid password as the text in the textfield is now
      //2 characters in length
      expect(pswdErrorFinder, findsOneWidget);

      //Aquire focus in the TextFormField
      await tester.tap(passowrdInputFinder);
      // Enter '123' into the TextFormField.
      await tester.enterText(passowrdInputFinder, '123');
      // find error message
      pswdErrorFinder = find.text('Invalid password');
      // add delay
      await tester.pump(const Duration(milliseconds: 100));
      //test result: invalid password as the text in the textfield is now
      //3 characters in length
      expect(pswdErrorFinder, findsOneWidget);

      //Aquire focus in the TextFormField
      await tester.tap(passowrdInputFinder);
      // Enter '1234' into the TextFormField.
      await tester.enterText(passowrdInputFinder, '1234');
      // find error message
      pswdErrorFinder = find.text('Invalid password');
      // add delay
      await tester.pump(const Duration(milliseconds: 100));
      //test result: invalid password as the text in the textfield is now
      //4 characters in length
      expect(pswdErrorFinder, findsOneWidget);

      //Aquire focus in the TextFormField
      await tester.tap(passowrdInputFinder);
      // Enter '12345' into the TextFormField.
      await tester.enterText(passowrdInputFinder, '12345');
      // find error message
      pswdErrorFinder = find.text('Invalid password');
      // add delay
      await tester.pump(const Duration(milliseconds: 100));
      //test result: invalid password as the text in the textfield is now
      //5 characters in length
      expect(pswdErrorFinder, findsOneWidget);

      //Aquire focus in the TextFormField
      await tester.tap(passowrdInputFinder);
      // Enter '123456' into the TextFormField.
      await tester.enterText(passowrdInputFinder, '123456');
      // find error message
      pswdErrorFinder = find.text('Invalid password');
      // add delay
      await tester.pump(const Duration(milliseconds: 100));
      //test result: invalid password as the text in the textfield is now
      //6 characters in length
      expect(pswdErrorFinder, findsOneWidget);

      //Aquire focus in the TextFormField
      await tester.tap(passowrdInputFinder);
      // Enter '1234567' into the TextFormField.
      await tester.enterText(passowrdInputFinder, '1234567');
      // find error message
      pswdErrorFinder = find.text('Invalid password');
      // add delay
      await tester.pump(const Duration(milliseconds: 100));
      //test result: invalid password as the text in the textfield is now
      //7 characters in length
      expect(pswdErrorFinder, findsOneWidget);
    });

    testWidgets(
        'should be invalid (no uppercase characters) and return an error string',
        (WidgetTester tester) async {
      //test the PatternValidator

      //returns an instance of Momentum i.e. the app
      final widget = momentum();
      //builds and renders the provided widget
      await tester.pumpWidget(widget);
      //repeatedly triggers a rebuild of the widget when the state changes.
      await tester.pumpAndSettle();
      //find password input
      final passowrdInputFinder = find.byKey(Key('login_password'));
      //Aquire focus in the TextFormField
      await tester.tap(passowrdInputFinder);
      // Enter 'simekani@1' into the TextFormField.
      await tester.enterText(passowrdInputFinder, 'simekani@1');
      // find error message
      var pswdErrorFinder = find.text('Invalid password');
      // add delay
      await tester.pump(const Duration(milliseconds: 100));
      //test result: invalid password
      expect(pswdErrorFinder, findsOneWidget);
    });

    testWidgets(
        'should be invalid (no lowercase characters) and return an error string',
        (WidgetTester tester) async {
      //test the PatternValidator

      //returns an instance of Momentum i.e. the app
      final widget = momentum();
      //builds and renders the provided widget
      await tester.pumpWidget(widget);
      //repeatedly triggers a rebuild of the widget when the state changes.
      await tester.pumpAndSettle();
      //find password input
      final passowrdInputFinder = find.byKey(Key('login_password'));
      //Aquire focus in the TextFormField
      await tester.tap(passowrdInputFinder);
      // Enter 'SIMEKANI@1' into the TextFormField.
      await tester.enterText(passowrdInputFinder, 'SIMEKANI@1');
      // find error message
      var pswdErrorFinder = find.text('Invalid password');
      // add delay
      await tester.pump(const Duration(milliseconds: 100));
      //test result: invalid password
      expect(pswdErrorFinder, findsOneWidget);
    });

    testWidgets(
        'should be invalid (no numeric characters) and return an error string',
        (WidgetTester tester) async {
      //test the PatternValidator

      //returns an instance of Momentum i.e. the app
      final widget = momentum();
      //builds and renders the provided widget
      await tester.pumpWidget(widget);
      //repeatedly triggers a rebuild of the widget when the state changes.
      await tester.pumpAndSettle();
      //find password input
      final passowrdInputFinder = find.byKey(Key('login_password'));
      //Aquire focus in the TextFormField
      await tester.tap(passowrdInputFinder);
      // Enter 'Simekani@' into the TextFormField.
      await tester.enterText(passowrdInputFinder, 'Simekani@');
      // find error message
      var pswdErrorFinder = find.text('Invalid password');
      // add delay
      await tester.pump(const Duration(milliseconds: 100));
      //test result: invalid password
      expect(pswdErrorFinder, findsOneWidget);
    });

    testWidgets(
        'should be invalid (no special characters) and return an error string',
        (WidgetTester tester) async {
      //test the PatternValidator. Special characters include ! @ # $ & * ~.

      //returns an instance of Momentum i.e. the app
      final widget = momentum();
      //builds and renders the provided widget
      await tester.pumpWidget(widget);
      //repeatedly triggers a rebuild of the widget when the state changes.
      await tester.pumpAndSettle();
      //find password input
      final passowrdInputFinder = find.byKey(Key('login_password'));
      //Aquire focus in the TextFormField
      await tester.tap(passowrdInputFinder);
      // Enter 'Simekani1' into the TextFormField.
      await tester.enterText(passowrdInputFinder, 'Simekani1');
      // find error message
      var pswdErrorFinder = find.text('Invalid password');
      // add delay
      await tester.pump(const Duration(milliseconds: 100));
      //test result: invalid password
      expect(pswdErrorFinder, findsOneWidget);
    });

    testWidgets(
        'should be autovalidated as it is typed into input text form field',
        (WidgetTester tester) async {
      // returns an instance of Momentum i.e. the app
      final widget = momentum();
      // builds and renders the provided widget
      await tester.pumpWidget(widget);
      // repeatedly triggers a rebuild of the widget when the state changes.
      await tester.pumpAndSettle();
      //find password input
      final passowrdInputFinder = find.byKey(Key('login_password'));
      //Aquire focus in the TextFormField
      await tester.tap(passowrdInputFinder);
      // Enter 'M' into the TextFormField.
      await tester.enterText(passowrdInputFinder, 'M');
      // retrieve TextField Widget from Finder
      TextFormField pswdTextField = tester.widget(passowrdInputFinder);
      //TODO maybe loop through all characters?
      //test result: confirm auto validation with each character inputted
      expect(pswdTextField.autovalidateMode.index, 1);
    });
  }); //group password
}

void _test_login_button_widget() {
  //TODO test login API function
  //TODO test naviagtion
  //TODO test tap (leads to new screen)
  //TODO test submit form function
  //TODO test clear input function

//TODO ask Sthe about test naming convention
  group('Login Button', () {
    testWidgets('initiates and renders successfully.',
        (WidgetTester tester) async {
      //returns an instance of Momentum i.e. the app
      final widget = momentum();
      //builds and renders the provided widget
      await tester.pumpWidget(widget);
      //repeatedly triggers a rebuild of the widget when the state changes.
      await tester.pumpAndSettle();
      //find email input
      final loginButtonFinder = find.byKey(Key('login_button'));
      //test result
      expect(loginButtonFinder, findsOneWidget);
    });

    testWidgets(
        'successfully responds to user interaction (tap button) but fails to navigate to next page (as no form fields were filled) and returns error strings.',
        (WidgetTester tester) async {
      // returns an instance of Momentum i.e. the app
      final widget = momentum();
      // builds and renders the provided widget
      await tester.pumpWidget(widget);
      // repeatedly triggers a rebuild of the widget when the state changes.
      await tester.pumpAndSettle();
      // Tap the login button.
      await tester.tap(find.byKey(Key('login_button')));
      // find error message
      final textErrorFinder = find.text('* Required');
      // Expect to find 2 error messages for both unfilled form fields.
      expect(textErrorFinder, findsNWidgets(2));
    });

    testWidgets(
        'successfully responds to user interaction (tap button) but fails to navigate to next page (only email form field was incorrectly filled, password left empty) and returns error strings.',
        (WidgetTester tester) async {
      // returns an instance of Momentum i.e. the app
      final widget = momentum();
      // builds and renders the provided widget
      await tester.pumpWidget(widget);
      // repeatedly triggers a rebuild of the widget when the state changes.
      await tester.pumpAndSettle();
      // Tap the login button.
      await tester.tap(find.byKey(Key('login_button')));
      // find email input
      final emailInputFinder = find.byKey(Key('login_email'));
      //Aquire focus in the TextFormField
      await tester.tap(emailInputFinder);
      // Enter 'invalid email' into the TextFormField.
      await tester.enterText(emailInputFinder, 'invalid email');
      // find error message
      final emailErrorFinder = find.text('Invalid email address');
      // add delay
      await tester.pump(const Duration(milliseconds: 100));
      // find error message
      final pswdErrorFinder = find.text('* Required');
      // Expect to find 1 error message for invalid email
      expect(emailErrorFinder, findsOneWidget);
      // Expect to find 1 error message for empty password input field
      expect(pswdErrorFinder, findsOneWidget);
    });

    testWidgets(
        'successfully responds to user interaction (tap button) but fails to navigate to next page (only password form field was incorrectly filled, email left empty) and returns error strings.',
        (WidgetTester tester) async {
      // returns an instance of Momentum i.e. the app
      final widget = momentum();
      // builds and renders the provided widget
      await tester.pumpWidget(widget);
      // repeatedly triggers a rebuild of the widget when the state changes.
      await tester.pumpAndSettle();
      // Tap the login button.
      await tester.tap(find.byKey(Key('login_button')));
      //find password input
      final pswdInputFinder = find.byKey(Key('login_password'));
      //Aquire focus in the TextFormField
      await tester.tap(pswdInputFinder);
      // Enter 'invalid password' into the TextFormField.
      await tester.enterText(pswdInputFinder, 'invalid password');
      // find error message
      final pswdErrorFinder = find.text('Invalid password');
      // add delay
      await tester.pump(const Duration(milliseconds: 100));
      // find error message
      final emailErrorFinder = find.text('* Required');
      // Expect to find 1 error message for empty email input field
      expect(emailErrorFinder, findsOneWidget);
      // Expect to find 1 error message for invalid password
      expect(pswdErrorFinder, findsOneWidget);
    });

    testWidgets(
        'successfully responds to user interaction (tap button) but fails to navigate to next page (both form fields are incorrectly filled) and returns error strings.',
        (WidgetTester tester) async {
      // returns an instance of Momentum i.e. the app
      final widget = momentum();
      // builds and renders the provided widget
      await tester.pumpWidget(widget);
      // repeatedly triggers a rebuild of the widget when the state changes.
      await tester.pumpAndSettle();
      // Tap the login button.
      await tester.tap(find.byKey(Key('login_button')));
      // find email input
      final emailInputFinder = find.byKey(Key('login_email'));
      //Aquire focus in the TextFormField
      await tester.tap(emailInputFinder);
      // Enter 'invalid email' into the TextFormField.
      await tester.enterText(emailInputFinder, 'invalid email');
      // find error message
      final emailErrorFinder = find.text('Invalid email address');
      // add delay
      await tester.pump(const Duration(milliseconds: 100));
      //find password input
      final pswdInputFinder = find.byKey(Key('login_password'));
      //Aquire focus in the TextFormField
      await tester.tap(pswdInputFinder);
      // Enter 'invalid password' into the TextFormField.
      await tester.enterText(pswdInputFinder, 'invalid password');
      // find error message
      final pswdErrorFinder = find.text('Invalid password');
      // add delay
      await tester.pump(const Duration(milliseconds: 100));
      // Expect to find 1 error message for invalid email
      expect(emailErrorFinder, findsOneWidget);
      // Expect to find 1 error message for invalid password
      expect(pswdErrorFinder, findsOneWidget);
    });

    testWidgets(
        'successfully responds to user interaction (tap button)and  navigates to next page as both form fields are correctly filled',
        (WidgetTester tester) async {
      // returns an instance of Momentum i.e. the app
      final widget = momentum();
      // builds and renders the provided widget
      await tester.pumpWidget(widget);
      // repeatedly triggers a rebuild of the widget when the state changes.
      await tester.pumpAndSettle();
      // Tap the login button.
      await tester.tap(find.byKey(Key('login_button')));
      // find email input
      final emailInputFinder = find.byKey(Key('login_email'));
      //Aquire focus in the TextFormField
      await tester.tap(emailInputFinder);
      // Enter 'Sime' into the TextFormField.
      await tester.enterText(emailInputFinder, 'invalid email');
      // find error message
      final emailErrorFinder = find.text('Invalid email address');
      // add delay
      await tester.pump(const Duration(milliseconds: 100));
      //find password input
      final pswdInputFinder = find.byKey(Key('login_password'));
      //Aquire focus in the TextFormField
      await tester.tap(pswdInputFinder);
      // Enter 'invalid password' into the TextFormField.
      await tester.enterText(pswdInputFinder, 'invalid password');
      // find error message
      final pswdErrorFinder = find.text('Invalid password');
      // add delay
      await tester.pump(const Duration(milliseconds: 100));
      // Expect to find 1 error message for invalid email
      expect(emailErrorFinder, findsOneWidget);
      // Expect to find 1 error message for invalid password
      expect(pswdErrorFinder, findsOneWidget);
    });
  }); //group 'login button'
}
////////////////////////////////////////////////////////////////////////////////

/////////////////////////////// UNIT TESTS /////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////

/////////////////////////// INTEGRATION TESTS //////////////////////////////////
void _connection_to_driver() {
  /*
  group('Connection to driver', () {
    FlutterDriver driver;

    //method to connect to Flutter driver
    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    tearDownAll(() async {
      if (driver != null) {
        await driver.close();
      }
    });
  }); //group
  */
}

void _test_email_integration() {
  /*
  group('Email', () {
    testWidgets(
        'input text form field successfully responds to user interaction: re-entering text',
        (WidgetTester tester) async {
      //TODO implement integration test version of this unit test: https://medium.com/flutter-community/testing-flutter-ui-with-flutter-driver-c1583681e337
    });

    testWidgets('re-entered in the text form field is displayed successfully',
        (WidgetTester tester) async {
      //TODO implement integration test version of this unit test: https://medium.com/flutter-community/testing-flutter-ui-with-flutter-driver-c1583681e337
    });
  }); 
  */
}
////////////////////////////////////////////////////////////////////////////////
