//TODO "widget testing" https://www.xamantra.dev/momentum/#/testing?id=widget-test
//TODO "unit testing controllers, models and services" https://www.xamantra.dev/momentum/#/testing?id=momentumtester https://www.xamantra.dev/momentum/#/momentum-tester

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile/main.dart';
import 'package:mobile/src/Components/User/Controller/UserController.dart';
import 'package:mobile/src/Pages/HomePage/Controller/HomeController.dart';
import 'package:mobile/src/Pages/LessonsPage/Controller/LessonController.dart';
import 'package:mobile/src/Pages/LoginPage/View/LoginPage.dart';
import 'package:mobile/src/Pages/SubjectsPage/Controller/SubjectController.dart';
import 'package:momentum/momentum.dart';

void main() {
  _test_form();
  _test_text();
  _test_email();
}

void _test_form() {
  testWidgets('All text form fields initialise and render successfully',
      (WidgetTester tester) async {
    await tester.pumpWidget(LoginPage());
    expect(find.byType(TextFormField), findsNWidgets(2));
  });
}

//TODO choose peace and ask Sthe bro
void _test_text() {
  group('Text', () {
    testWidgets('initialises and renders successfully',
        (WidgetTester tester) async {
      //returns an instance of Momentum i.e. the app
      final widget = momentum();
      //builds and renders the provided widget
      await tester.pumpWidget(widget);
      //repeatedly triggers a rebuild of the widget
      await tester.pumpAndSettle();

      //find page title "User Registration"
      final userHeadingFinder = find.byKey(Key('login_registration_heading'));
      final registrationHeadingFinder = find.byKey(Key('login_user_heading'));
      expect(userHeadingFinder, findsOneWidget);
      expect(registrationHeadingFinder, findsOneWidget);
    });
  });
}

void _test_email() {
  group('Email', () {
    testWidgets('input field renders successfully',
        (WidgetTester tester) async {
      await tester.pumpWidget(MyApp());
      expect(find.byKey(Key('login_email')), findsOneWidget);
    });
    //TODO valid email address
    testWidgets(
        'should be invalid (missing the "@" AND ".com" symbol) and return an error string',
        (WidgetTester tester) async {
      await tester.pumpWidget(LoginPage());
      /*
      expect(find.byType(TextFormField), findsOneWidget);
      await tester.pump();
      await tester.enterText(find.byType(EditableText), "0.2");
*/
    });
    //TODO not empty
  });
}

//TODO pump duration https://stackoverflow.com/questions/50034957/cant-enter-text-in-flutter-test