// EduGo Web App Log In Page widget test.

import 'package:edugo_web_app/main.dart';
import 'package:edugo_web_app/src/Pages/EduGo.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets(
    'Log In Page Component Rendering',
    (WidgetTester tester) async {
      // Info: Testing if all components of the Log In page render successfully
      final widget = momentum();
      await tester.pumpWidget(widget);
      await tester.pumpAndSettle();

      final signInButton = find.byKey(Key("SignInButton"));

      expect(signInButton, findsOneWidget);
      await tester.tap(signInButton);
      await tester.pumpAndSettle();

      final logInContentWidget = find.byKey(Key("LogInContent"));

      expect(logInContentWidget, findsOneWidget);
    },
  );
  testWidgets(
    'User Name Field Blank Error Test ',
    (WidgetTester tester) async {
      // Info: Testing if user name input box returns error message when blank
      final widget = momentum();
      await tester.pumpWidget(widget);
      await tester.pumpAndSettle();

      final signInViewButton = find.byKey(Key("SignInButton"));
      await tester.tap(signInViewButton);
      await tester.pumpAndSettle();

      final logInButton = find.byKey(Key("LogInButton"));
      await tester.tap(logInButton);
      await tester.pumpAndSettle();

      final emptyUserName = find.text("User name cannot be blank");
      expect(emptyUserName, findsOneWidget);
    },
  );

  testWidgets(
    'Password Field Blank Error Test ',
    (WidgetTester tester) async {
      // Info: Testing if password input box returns error message when blank
      final widget = momentum();
      await tester.pumpWidget(widget);
      await tester.pumpAndSettle();

      final signInViewButton = find.byKey(Key("SignInButton"));
      await tester.tap(signInViewButton);
      await tester.pumpAndSettle();

      final logInButton = find.byKey(Key("LogInButton"));
      await tester.tap(logInButton);
      await tester.pumpAndSettle();

      final emptyPassword = find.text("Password cannot be blank");
      expect(emptyPassword, findsOneWidget);
    },
  );

  testWidgets(
    'User Name Field Input Test ',
    (WidgetTester tester) async {
      // Info: Testing if user name input box does not return an error message when filled in
      final widget = momentum();
      await tester.pumpWidget(widget);
      await tester.pumpAndSettle();

      final signInViewButton = find.byKey(Key("SignInButton"));
      await tester.tap(signInViewButton);
      await tester.pumpAndSettle();

      await tester.enterText(find.byKey(Key("LogInUserName")), 'username');

      final logInButton = find.byKey(Key("LogInButton"));
      await tester.tap(logInButton);
      await tester.pumpAndSettle();

      final emptyUserName = find.text("User name cannot be blank");
      expect(emptyUserName, findsNothing);
    },
  );

  testWidgets(
    'Password Field Input Test  ',
    (WidgetTester tester) async {
      // Info: Testing if user name input box does not return an error message when filled in
      final widget = momentum();
      await tester.pumpWidget(widget);
      await tester.pumpAndSettle();

      final signInViewButton = find.byKey(Key("SignInButton"));
      await tester.tap(signInViewButton);
      await tester.pumpAndSettle();

      await tester.enterText(find.byKey(Key("LogInPassword")), 'password');

      final logInButton = find.byKey(Key("LogInButton"));
      await tester.tap(logInButton);
      await tester.pumpAndSettle();

      final emptyPassword = find.text("Password cannot be blank");
      expect(emptyPassword, findsNothing);
    },
  );
}
