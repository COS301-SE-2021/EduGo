import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:mobile/main.dart';
import 'package:mobile/src/Components/User/Controller/UserController.dart';
import 'package:mobile/src/Pages/RegistrationPage/View/RegistrationPage.dart';
import 'package:mobile/src/Pages/RegistrationPage/View/RegistrationVerificationPage.dart';
import 'package:momentum/momentum.dart';

//NUMBER OF TESTS SO FAR: 0

void main() {
//TODO Implement widget tests
  _widget_tests();

//TODO Implement unit tests: _unit_tests();

//TODO Implement integration tests: _integration_tests();
}

void _buildRegPage(WidgetTester tester) async {
  //create widget to test
  final widget = Momentum(
      child: MaterialApp(
        home: RegistrationPage(Key('regPageHeading')),
      ),
      controllers: [
        UserController(),
      ]);
  //call the widget's build fuction and render widget
  await tester.pumpWidget(widget);
  //automatically rebuild widget when state changes
  await tester.pumpAndSettle();
}

//testWidgets('description.', (WidgetTester tester) async {});
///////////////////////////// WIDGET TESTS /////////////////////////////////////
void _widget_tests() {
  //TODO test logo image
  group('Image', () {
    testWidgets('should render successfully.', (WidgetTester tester) async {});
  }); //group

//TODO test _pageTitle,
  group('Heading', () {
    testWidgets('should render successfully.', (WidgetTester tester) async {
      _buildRegPage(tester);
      final heading = find.text("User Registration");
      // Expect one heading to render
      expect(heading, findsOneWidget);
    });
  }); //group

//TODO test_userTypeField,
  group('User type', () {
    testWidgets('input field should render successfully.',
        (WidgetTester tester) async {});
  }); //group

//TODO test_orgTypeField,
  group('Organisation type', () {
    testWidgets('input field should render successfully.',
        (WidgetTester tester) async {});
  }); //group

//TODO test_usernameField,
  group('Username', () {
    testWidgets('input field should render successfully.',
        (WidgetTester tester) async {});
  }); //group

//TODO test_firstNameField,
  group('First Name', () {
    testWidgets('input field should render successfully.',
        (WidgetTester tester) async {});
  }); //group

//TODO test_lastNameField,
  group('Last Name', () {
    testWidgets('input field should render successfully.',
        (WidgetTester tester) async {});
  }); //group

//TODO test_emailField,
  group('Email', () {
    testWidgets('input field should render successfully.',
        (WidgetTester tester) async {});
  }); //group

//TODO test_regButton,
  group('Register button', () {
    testWidgets('should render successfully.', (WidgetTester tester) async {});
  }); //group
}//_widget_tests
