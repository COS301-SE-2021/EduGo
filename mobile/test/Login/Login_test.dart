//TODO "widget testing" https://www.xamantra.dev/momentum/#/testing?id=widget-test
//TODO "unit testing controllers, models and services" https://www.xamantra.dev/momentum/#/testing?id=momentumtester https://www.xamantra.dev/momentum/#/momentum-tester

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile/main.dart';
import 'package:mobile/src/Pages/LoginPage/View/LoginPage.dart';

//TOTAL NUMBER OF TESTS: 11
void main() {
  _test_alignment();
  _test_form();
  _test_text();
  _test_email();
  //_test_password();
}

//TODO implemet testing for alignment of widgets?
void _test_alignment() {}
void _test_form() {
  //TODO
  testWidgets('All text form fields initialise and render successfully',
      (WidgetTester tester) async {
    await tester.pumpWidget(LoginPage());
    expect(find.byType(TextFormField), findsNWidgets(2));
  });
}

void _test_text() {
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

void _test_email() {
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

    //TODO integration test
    testWidgets(
        'input text form field successfully responds to user interaction: re-entering text',
        (WidgetTester tester) async {});

    //TODO integration test
    testWidgets('re-entered in the text form field is displayed successfully',
        (WidgetTester tester) async {});

    //TODO valid email address
    testWidgets(
        'should be invalid (missing the "@" AND ".com" symbol) and return an error string',
        (WidgetTester tester) async {
      //returns an instance of Momentum i.e. the app
      final widget = momentum();
      //builds and renders the provided widget
      await tester.pumpWidget(widget);
      //repeatedly triggers a rebuild of the widget when the state changes.
      await tester.pumpAndSettle();
      //test result
      await tester.enterText(find.byKey(Key('login_email')), "m");
    });
    //TODO not empty
  });
  //TODO valid email address
  testWidgets('should be invalid (missing the "@") and return an error string',
      (WidgetTester tester) async {});

  //TODO valid email address
  testWidgets('should be invalid (".com" symbol) and return an error string',
      (WidgetTester tester) async {
    //.only
  });
  //TODO valid email address
  testWidgets('should be invalid (".com" symbol) and return an error string',
      (WidgetTester tester) async {
    //com without dot
  });
}

//TODO
void _test_password() {}

//TODO user interaction test: https://flutter.dev/docs/cookbook/testing/widget/tap-drag
//TODO flutter driver (more complex integretion testing): https://medium.com/flutter-community/testing-flutter-ui-with-flutter-driver-c1583681e337
// tester (single widget unit testing): https://stackoverflow.com/questions/62635696/flutter-widget-vs-flutter-driver
