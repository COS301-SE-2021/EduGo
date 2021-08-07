//this file contains the actual test scripts that we are going to write by using
//tester methods

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile/main.dart';
import 'package:mobile/src/Pages/LoginPage/View/LoginPage.dart';

//TOTAL NUMBER OF TESTS: 13
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
  _test_form_widget();
  _test_text_widget();
  _test_email_widget();
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
//TODO implement
void _test_form_widget() {
  group('All Text Form Field inputs ', () {
    testWidgets('should be empty and return an error string',
        (WidgetTester tester) async {
      //returns an instance of Momentum i.e. the app
      final widget = momentum();
      //builds and renders the provided widget
      await tester.pumpWidget(widget);
      //repeatedly triggers a rebuild of the widget when the state changes.
      await tester.pumpAndSettle();
      // find all input fields
      final textInputFinder = find.byType(TextFormField);
      // retrieve TextField Widget from Finder
      TextFormField textFormField = tester.widget(textInputFinder);
      // find error message
      final emailErrorFinder = find.text('* Required');
      // add delay
      await tester.pump(const Duration(milliseconds: 100));
      // test result: confirm TextField is empty
      expect(textFormField.controller!.text, equals(""));
      //test result: invalid email error
      expect(emailErrorFinder, findsNWidgets(2));
    });
  }); //group
}

//TODO implement
void _test_text_widget() {
  group('Text', () {
    testWidgets('initialises and renders successfully',
        (WidgetTester tester) async {
      //returns an instance of Momentum i.e. the app
      final widget = momentum();
      //builds and renders the provided widget
      await tester.pumpWidget(widget);
      //repeatedly triggers a rebuild of the widget when the state changes.
      await tester.pumpAndSettle();

      //find page title "User Registration"
      final userHeadingFinder = find.byKey(Key('login_registration_heading'));
      final registrationHeadingFinder = find.byKey(Key('login_user_heading'));

      //test results
      expect(userHeadingFinder, findsOneWidget);
      expect(registrationHeadingFinder, findsOneWidget);
    });
  });
}

void _test_email_widget() {
  //10 tests
  group('Email', () {
    testWidgets('input field renders successfully.',
        (WidgetTester tester) async {
      //returns an instance of Momentum i.e. the app
      final widget = momentum();
      //builds and renders the provided widget
      await tester.pumpWidget(widget);
      //repeatedly triggers a rebuild of the widget when the state changes.
      await tester.pumpAndSettle();
      //find email input
      final emailInputFinder = find.byKey(Key('login_email'));
      //test result
      expect(emailInputFinder, findsOneWidget);
    });

    testWidgets('input field should be empty.', (WidgetTester tester) async {
      // returns an instance of Momentum i.e. the app
      final widget = momentum();
      // builds and renders the provided widget
      await tester.pumpWidget(widget);
      // repeatedly triggers a rebuild of the widget when the state changes.
      await tester.pumpAndSettle();
      // find email input
      final emailInputFinder = find.byKey(Key('login_email'));
      // retrieve TextField Widget from Finder
      TextFormField emailTextField = tester.widget(emailInputFinder);
      // test result: confirm TextField is empty
      expect(emailTextField.controller!.text, equals(""));
    });
//TODO when tap node should focus: https://github.com/flutter/flutter/blob/master/packages/flutter/test/material/text_field_focus_test.dart
    testWidgets(
        'input text form field successfully responds to user interaction: entering text', //is successfully entered into the input text form filed
        (WidgetTester tester) async {
      //returns an instance of Momentum i.e. the app
      final widget = momentum();
      //builds and renders the provided widget
      await tester.pumpWidget(widget);
      //repeatedly triggers a rebuild of the widget when the state changes.
      await tester.pumpAndSettle();
      //find email input
      final emailInputFinder = find.byKey(Key('login_email'));
      //Aquire focus in the TextFormField
      await tester.tap(emailInputFinder);
      // Enter 'Mihlali' into the TextFormField.
      await tester.enterText(emailInputFinder, 'Mihlali');
    });

    testWidgets(' entered in the text form field is displayed successfully',
        (WidgetTester tester) async {
      // returns an instance of Momentum i.e. the app
      final widget = momentum();
      // builds and renders the provided widget
      await tester.pumpWidget(widget);
      // repeatedly triggers a rebuild of the widget when the state changes.
      await tester.pumpAndSettle();
      // find email input
      final emailInputFinder = find.byKey(Key('login_email'));
      //Aquire focus in the TextFormField
      await tester.tap(emailInputFinder);
      // Enter 'Mihlali' into the TextFormField.
      await tester.enterText(emailInputFinder, 'Mihlali');
      // retrieve TextField Widget from Finder
      TextFormField emailTextField = tester.widget(emailInputFinder);
      // test result: confirm TextField is empty
      expect(emailTextField.controller!.text, equals("Mihlali"));
    });

    testWidgets('input field should be empty and return an error string',
        (WidgetTester tester) async {
      //returns an instance of Momentum i.e. the app
      final widget = momentum();
      //builds and renders the provided widget
      await tester.pumpWidget(widget);
      //repeatedly triggers a rebuild of the widget when the state changes.
      await tester.pumpAndSettle();
      // find email input
      final emailInputFinder = find.byKey(Key('login_email'));
      // retrieve TextField Widget from Finder
      TextFormField emailTextField = tester.widget(emailInputFinder);
      // find error message
      final emailErrorFinder = find.text('* Required');
      // add delay
      await tester.pump(const Duration(milliseconds: 100));
      // test result: confirm TextField is empty
      expect(emailTextField.controller!.text, equals(""));

      //test result: invalid email error
      expect(emailErrorFinder, findsWidgets);
    });
    testWidgets(
        'should be invalid (missing the "@" AND ".com" symbol) and return an error string',
        (WidgetTester tester) async {
      //returns an instance of Momentum i.e. the app
      final widget = momentum();
      //builds and renders the provided widget
      await tester.pumpWidget(widget);
      //repeatedly triggers a rebuild of the widget when the state changes.
      await tester.pumpAndSettle();
      // find email input
      final emailInputFinder = find.byKey(Key('login_email'));
      //Aquire focus in the TextFormField
      await tester.tap(emailInputFinder);
      // Enter 'Mihlali' into the TextFormField.
      await tester.enterText(emailInputFinder, 'Mihlali');
      // find error message
      final emailErrorFinder = find.text('Invalid email address'); //* Required
      // add delay
      await tester.pump(const Duration(milliseconds: 100));
      //test result: invalid email error
      expect(emailErrorFinder, findsOneWidget);
    });

    testWidgets(
        'should be invalid (missing the "@") and return an error string',
        (WidgetTester tester) async {
      //returns an instance of Momentum i.e. the app
      final widget = momentum();
      //builds and renders the provided widget
      await tester.pumpWidget(widget);
      //repeatedly triggers a rebuild of the widget when the state changes.
      await tester.pumpAndSettle();
      // find email input
      final emailInputFinder = find.byKey(Key('login_email'));
      //Aquire focus in the TextFormField
      await tester.tap(emailInputFinder);
      // Enter 'Mihlali' into the TextFormField.
      await tester.enterText(emailInputFinder, 'Mihlali"gmail.com');
      // find error message
      final emailErrorFinder = find.text('Invalid email address'); //* Required
      // add delay
      await tester.pump(const Duration(milliseconds: 100));
      //test result: invalid email error
      expect(emailErrorFinder, findsOneWidget);
    });

    testWidgets(
        'should be invalid (missing "com" of the ".com" symbol) and return an error string',
        (WidgetTester tester) async {
      //returns an instance of Momentum i.e. the app
      final widget = momentum();
      //builds and renders the provided widget
      await tester.pumpWidget(widget);
      //repeatedly triggers a rebuild of the widget when the state changes.
      await tester.pumpAndSettle();
      // find email input
      final emailInputFinder = find.byKey(Key('login_email'));
      //Aquire focus in the TextFormField
      await tester.tap(emailInputFinder);
      // Enter 'Mihlali' into the TextFormField.
      await tester.enterText(emailInputFinder, 'Mihlali@gmail.');
      // find error message
      final emailErrorFinder = find.text('Invalid email address'); //* Required
      // add delay
      await tester.pump(const Duration(milliseconds: 100));
      //test result: invalid email error
      expect(emailErrorFinder, findsOneWidget);
    });

    testWidgets(
        'should be invalid (missing "com" of the ".com" symbol) and return an error string',
        (WidgetTester tester) async {
      //returns an instance of Momentum i.e. the app
      final widget = momentum();
      //builds and renders the provided widget
      await tester.pumpWidget(widget);
      //repeatedly triggers a rebuild of the widget when the state changes.
      await tester.pumpAndSettle();
      // find email input
      final emailInputFinder = find.byKey(Key('login_email'));
      //Aquire focus in the TextFormField
      await tester.tap(emailInputFinder);
      // Enter 'Mihlali' into the TextFormField.
      await tester.enterText(emailInputFinder, 'Mihlali@gmail_com');
      // find error message
      final emailErrorFinder = find.text('Invalid email address'); //* Required
      // add delay
      await tester.pump(const Duration(milliseconds: 100));
      //test result: invalid email error
      expect(emailErrorFinder, findsOneWidget);
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
      // find email input
      final emailInputFinder = find.byKey(Key('login_email'));
      //Aquire focus in the TextFormField
      await tester.tap(emailInputFinder);
      // Enter 'Mihlali' into the TextFormField.
      await tester.enterText(emailInputFinder, 'M');
      // retrieve TextField Widget from Finder
      TextFormField emailTextField = tester.widget(emailInputFinder);
      //TODO maybe loop through all characters?
      // test result: confirm auto validation with each character inputted
      expect(emailTextField.autovalidateMode.index, 1);
    });
  }); //group email
}

//TODO implement
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
      //find email input
      final passowrdInputFinder = find.byKey(Key('login_password'));
      //test result
      expect(passowrdInputFinder, findsOneWidget);
    });
/*
    testWidgets('input field should be empty.', (WidgetTester tester) async {
      // returns an instance of Momentum i.e. the app
      final widget = momentum();
      // builds and renders the provided widget
      await tester.pumpWidget(widget);
      // repeatedly triggers a rebuild of the widget when the state changes.
      await tester.pumpAndSettle();
      // find email input
      final emailInputFinder = find.byKey(Key('login_email'));
      // retrieve TextField Widget from Finder
      TextFormField emailTextField = tester.widget(emailInputFinder);
      // test result: confirm TextField is empty
      expect(emailTextField.controller!.text, equals(""));
    });
//TODO when tap node should focus: https://github.com/flutter/flutter/blob/master/packages/flutter/test/material/text_field_focus_test.dart
    testWidgets(
        'input text form field successfully responds to user interaction: entering text', //is successfully entered into the input text form filed
        (WidgetTester tester) async {
      //returns an instance of Momentum i.e. the app
      final widget = momentum();
      //builds and renders the provided widget
      await tester.pumpWidget(widget);
      //repeatedly triggers a rebuild of the widget when the state changes.
      await tester.pumpAndSettle();
      //find email input
      final emailInputFinder = find.byKey(Key('login_email'));
      //Aquire focus in the TextFormField
      await tester.tap(emailInputFinder);
      // Enter 'Mihlali' into the TextFormField.
      await tester.enterText(emailInputFinder, 'Mihlali');
    });

    testWidgets(' entered in the text form field is displayed successfully',
        (WidgetTester tester) async {
      // returns an instance of Momentum i.e. the app
      final widget = momentum();
      // builds and renders the provided widget
      await tester.pumpWidget(widget);
      // repeatedly triggers a rebuild of the widget when the state changes.
      await tester.pumpAndSettle();
      // find email input
      final emailInputFinder = find.byKey(Key('login_email'));
      //Aquire focus in the TextFormField
      await tester.tap(emailInputFinder);
      // Enter 'Mihlali' into the TextFormField.
      await tester.enterText(emailInputFinder, 'Mihlali');
      // retrieve TextField Widget from Finder
      TextFormField emailTextField = tester.widget(emailInputFinder);
      // test result: confirm TextField is empty
      expect(emailTextField.controller!.text, equals("Mihlali"));
    });

    testWidgets('input field should be empty and return an error string',
        (WidgetTester tester) async {
      //returns an instance of Momentum i.e. the app
      final widget = momentum();
      //builds and renders the provided widget
      await tester.pumpWidget(widget);
      //repeatedly triggers a rebuild of the widget when the state changes.
      await tester.pumpAndSettle();
      // find email input
      final emailInputFinder = find.byKey(Key('login_email'));
      // retrieve TextField Widget from Finder
      TextFormField emailTextField = tester.widget(emailInputFinder);
      // find error message
      final emailErrorFinder = find.text('* Required');
      // add delay
      await tester.pump(const Duration(milliseconds: 100));
      // test result: confirm TextField is empty
      expect(emailTextField.controller!.text, equals(""));

      //test result: invalid email error
      expect(emailErrorFinder, findsOneWidget);
    });
    testWidgets(
        'should be invalid (missing the "@" AND ".com" symbol) and return an error string',
        (WidgetTester tester) async {
      //returns an instance of Momentum i.e. the app
      final widget = momentum();
      //builds and renders the provided widget
      await tester.pumpWidget(widget);
      //repeatedly triggers a rebuild of the widget when the state changes.
      await tester.pumpAndSettle();
      // find email input
      final emailInputFinder = find.byKey(Key('login_email'));
      //Aquire focus in the TextFormField
      await tester.tap(emailInputFinder);
      // Enter 'Mihlali' into the TextFormField.
      await tester.enterText(emailInputFinder, 'Mihlali');
      // find error message
      final emailErrorFinder = find.text('Invalid email address'); 
      // add delay
      await tester.pump(const Duration(milliseconds: 100));
      //test result: invalid email error
      expect(emailErrorFinder, findsOneWidget);
    });

    testWidgets(
        'should be invalid (missing the "@") and return an error string',
        (WidgetTester tester) async {
      //returns an instance of Momentum i.e. the app
      final widget = momentum();
      //builds and renders the provided widget
      await tester.pumpWidget(widget);
      //repeatedly triggers a rebuild of the widget when the state changes.
      await tester.pumpAndSettle();
      // find email input
      final emailInputFinder = find.byKey(Key('login_email'));
      //Aquire focus in the TextFormField
      await tester.tap(emailInputFinder);
      // Enter 'Mihlali' into the TextFormField.
      await tester.enterText(emailInputFinder, 'Mihlali"gmail.com');
      // find error message
      final emailErrorFinder = find.text('Invalid email address'); 
      // add delay
      await tester.pump(const Duration(milliseconds: 100));
      //test result: invalid email error
      expect(emailErrorFinder, findsOneWidget);
    });

    testWidgets(
        'should be invalid (missing "com" of the ".com" symbol) and return an error string',
        (WidgetTester tester) async {
      //returns an instance of Momentum i.e. the app
      final widget = momentum();
      //builds and renders the provided widget
      await tester.pumpWidget(widget);
      //repeatedly triggers a rebuild of the widget when the state changes.
      await tester.pumpAndSettle();
      // find email input
      final emailInputFinder = find.byKey(Key('login_email'));
      //Aquire focus in the TextFormField
      await tester.tap(emailInputFinder);
      // Enter 'Mihlali' into the TextFormField.
      await tester.enterText(emailInputFinder, 'Mihlali@gmail.');
      // find error message
      final emailErrorFinder = find.text('Invalid email address');
      // add delay
      await tester.pump(const Duration(milliseconds: 100));
      //test result: invalid email error
      expect(emailErrorFinder, findsOneWidget);
    });

    testWidgets(
        'should be invalid (missing "com" of the ".com" symbol) and return an error string',
        (WidgetTester tester) async {
      //returns an instance of Momentum i.e. the app
      final widget = momentum();
      //builds and renders the provided widget
      await tester.pumpWidget(widget);
      //repeatedly triggers a rebuild of the widget when the state changes.
      await tester.pumpAndSettle();
      // find email input
      final emailInputFinder = find.byKey(Key('login_email'));
      //Aquire focus in the TextFormField
      await tester.tap(emailInputFinder);
      // Enter 'Mihlali' into the TextFormField.
      await tester.enterText(emailInputFinder, 'Mihlali@gmail_com');
      // find error message
      final emailErrorFinder = find.text('Invalid email address'); 
      // add delay
      await tester.pump(const Duration(milliseconds: 100));
      //test result: invalid email error
      expect(emailErrorFinder, findsOneWidget);
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
      // find email input
      final emailInputFinder = find.byKey(Key('login_email'));
      //Aquire focus in the TextFormField
      await tester.tap(emailInputFinder);
      // Enter 'Mihlali' into the TextFormField.
      await tester.enterText(emailInputFinder, 'M');
      // retrieve TextField Widget from Finder
      TextFormField emailTextField = tester.widget(emailInputFinder);
      //TODO maybe loop through all characters?
      // test result: confirm auto validation with each character inputted
      expect(emailTextField.autovalidateMode.index, 1);
    });
    */
  }); //group password
}

void _test_login_button_widget() {
  //TODO test login API function
  //TODO test naviagtion
  //TODO test render
  //TODO test tap
  //TODO test submit form function
  //TODO test clear input function
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
