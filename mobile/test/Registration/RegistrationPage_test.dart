import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:mobile/main.dart';
import 'package:mobile/src/Components/User/Controller/UserController.dart';
import 'package:mobile/src/Pages/RegistrationPage/View/RegistrationPage.dart';
import 'package:mobile/src/Pages/RegistrationPage/View/RegistrationVerificationPage.dart';
import 'package:momentum/momentum.dart';

//NUMBER OF TESTS SO FAR: 12

void main() {
//TODO Implement widget tests
  _widget_tests();

//TODO Implement unit tests: _unit_tests();

//TODO Implement integration tests: _integration_tests();
}

//testWidgets('description.', (WidgetTester tester) async {});
///////////////////////////// WIDGET TESTS /////////////////////////////////////
void _widget_tests() {
  //TODO test icon
  //Todo test validators
  //TODO test logo image
  group('Image', () {
    testWidgets('should render successfully.', (WidgetTester tester) async {});
  }); //group

  group('Heading', () {
    testWidgets('text should render successfully.',
        (WidgetTester tester) async {
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
      final heading = find.text("User Registration");
      // Expect one heading to render
      expect(heading, findsOneWidget);
    });
  }); //group

  group('User type', () {
    testWidgets('input field should render successfully.',
        (WidgetTester tester) async {
      final widget = Momentum(
          child: MaterialApp(
            home: RegistrationPage(Key('regPageHeading')),
          ),
          controllers: [
            UserController(),
          ]);
      await tester.pumpWidget(widget);
      await tester.pumpAndSettle();
      final heading = find.text("Select a user type");
      expect(heading, findsOneWidget);
    });

    testWidgets('dropdown icon should render successfully.',
        (WidgetTester tester) async {
      final widget = Momentum(
          child: MaterialApp(
            home: RegistrationPage(Key('regPageHeading')),
          ),
          controllers: [
            UserController(),
          ]);
      await tester.pumpWidget(widget);
      await tester.pumpAndSettle();
      final userTypeIcon = find.byKey(Key('userTypeIcon'));
      expect(userTypeIcon, findsOneWidget);
    });
  }); //group

//TODO test_orgTypeField,
  group('Organisation type', () {
    testWidgets('input field should render successfully.',
        (WidgetTester tester) async {
      final widget = Momentum(
          child: MaterialApp(
            home: RegistrationPage(Key('regPageHeading')),
          ),
          controllers: [
            UserController(),
          ]);
      await tester.pumpWidget(widget);
      await tester.pumpAndSettle();
      final heading = find.text("Select an organisation");
      expect(heading, findsOneWidget);
    });

    testWidgets('dropdown icon should render successfully.',
        (WidgetTester tester) async {
      final widget = Momentum(
          child: MaterialApp(
            home: RegistrationPage(Key('regPageHeading')),
          ),
          controllers: [
            UserController(),
          ]);
      await tester.pumpWidget(widget);
      await tester.pumpAndSettle();
      final orgTypeIcon = find.byKey(Key('orgTypeIcon'));
      expect(orgTypeIcon, findsOneWidget);
    });
  }); //group

//TODO test_usernameField,
  group('Username', () {
    testWidgets('input field hint text should render successfully.',
        (WidgetTester tester) async {
      final widget = Momentum(
          child: MaterialApp(
            home: RegistrationPage(Key('regPageHeading')),
          ),
          controllers: [
            UserController(),
          ]);
      await tester.pumpWidget(widget);
      await tester.pumpAndSettle();
      final heading = find.text("Username");
      expect(heading, findsOneWidget);
    });

    testWidgets('icon should render successfully.',
        (WidgetTester tester) async {
      final widget = Momentum(
          child: MaterialApp(
            home: RegistrationPage(Key('regPageHeading')),
          ),
          controllers: [
            UserController(),
          ]);
      await tester.pumpWidget(widget);
      await tester.pumpAndSettle();
      final usernameIcon = find.byIcon(Icons.person);
      expect(usernameIcon, findsOneWidget);
    });
  }); //group

//TODO test_firstNameField,
  group('First Name', () {
    testWidgets('input field hint text  should render successfully.',
        (WidgetTester tester) async {
      final widget = Momentum(
          child: MaterialApp(
            home: RegistrationPage(Key('regPageHeading')),
          ),
          controllers: [
            UserController(),
          ]);
      await tester.pumpWidget(widget);
      await tester.pumpAndSettle();
      final heading = find.text("First Name");
      expect(heading, findsOneWidget);
    });
    testWidgets('icon should render successfully.',
        (WidgetTester tester) async {
      final widget = Momentum(
          child: MaterialApp(
            home: RegistrationPage(Key('regPageHeading')),
          ),
          controllers: [
            UserController(),
          ]);
      await tester.pumpWidget(widget);
      await tester.pumpAndSettle();
      final firstNameIcon = find.byIcon(Icons.person_add);
      expect(firstNameIcon, findsOneWidget);
    });
  }); //group

//TODO test_lastNameField,
  group('Last Name', () {
    testWidgets('input field should render successfully.',
        (WidgetTester tester) async {
      final widget = Momentum(
          child: MaterialApp(
            home: RegistrationPage(Key('regPageHeading')),
          ),
          controllers: [
            UserController(),
          ]);
      await tester.pumpWidget(widget);
      await tester.pumpAndSettle();
      final heading = find.text("Last Name");
      expect(heading, findsOneWidget);
    });

    testWidgets('icon should render successfully.',
        (WidgetTester tester) async {
      final widget = Momentum(
          child: MaterialApp(
            home: RegistrationPage(Key('regPageHeading')),
          ),
          controllers: [
            UserController(),
          ]);
      await tester.pumpWidget(widget);
      await tester.pumpAndSettle();
      final lastNameIcon = find.byIcon(Icons.person_add_alt_1);
      expect(lastNameIcon, findsOneWidget);
    });
  }); //group

//TODO test_emailField,
  group('Email', () {
    testWidgets('input field should render successfully.',
        (WidgetTester tester) async {
      final widget = Momentum(
          child: MaterialApp(
            home: RegistrationPage(Key('regPageHeading')),
          ),
          controllers: [
            UserController(),
          ]);
      await tester.pumpWidget(widget);
      await tester.pumpAndSettle();
      final heading = find.text("Email");
      expect(heading, findsOneWidget);
    });

    testWidgets('icon should render successfully.',
        (WidgetTester tester) async {
      final widget = Momentum(
          child: MaterialApp(
            home: RegistrationPage(Key('regPageHeading')),
          ),
          controllers: [
            UserController(),
          ]);
      await tester.pumpWidget(widget);
      await tester.pumpAndSettle();
      final usernameIcon = find.byIcon(Icons.email_outlined);
      expect(usernameIcon, findsOneWidget);
    });
  }); //group

//TODO test_regButton,
  group('Register', () {
    testWidgets('button should render successfully.',
        (WidgetTester tester) async {
      final widget = Momentum(
          child: MaterialApp(
            home: RegistrationPage(Key('regPageHeading')),
          ),
          controllers: [
            UserController(),
          ]);
      await tester.pumpWidget(widget);
      await tester.pumpAndSettle();
      final heading = find.text("Register");
      expect(heading, findsOneWidget);
    });

    testWidgets('icon should render successfully.',
        (WidgetTester tester) async {
      final widget = Momentum(
          child: MaterialApp(
            home: RegistrationPage(Key('regPageHeading')),
          ),
          controllers: [
            UserController(),
          ]);
      await tester.pumpWidget(widget);
      await tester.pumpAndSettle();
      final buttonIcon = find.byIcon(Icons.login_outlined);
      expect(buttonIcon, findsOneWidget);
    });
  }); //group
}//_widget_tests
