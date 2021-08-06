//https://medium.com/swlh/testing-in-flutter-ef7d509f3f75

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile/main.dart';
import 'package:mobile/src/Pages/LoginPage/View/LoginPage.dart';

void main() {
  _test_form();
  _test_text();
  _test_email();
}

void _test_form() {
  testWidgets('All text form fields render successfully',
      (WidgetTester tester) async {
    await tester.pumpWidget(LoginPage());
    expect(find.byType(TextFormField), findsNWidgets(2));
  });
}

//TODO choose peace and ask Sthe bro
void _test_text() {
  group('Text', () {
    testWidgets('renders successfully', (WidgetTester tester) async {
      await tester.pumpWidget(LoginPage());
      expect(find.text('User'), findsOneWidget);
      //expect(find.text('Registration'), findsOneWidget);
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