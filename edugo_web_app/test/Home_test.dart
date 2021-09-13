// EduGo Web App Hoome Page widget test.

import 'package:edugo_web_app/main.dart';
import 'package:edugo_web_app/src/Pages/EduGo.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets(
    'Home Page Component Rendering',
    (WidgetTester tester) async {
      // Info: Testing if all components of the home page render successfully
      final widget = momentum();
      await tester.pumpWidget(widget);
      await tester.pumpAndSettle();

      final homeWidget = find.byKey(Key("HomeView"));
      final homeNavigation = find.byKey(Key("HomeNavigation"));
      final homeContent = find.byKey(Key("HomeContent"));
      final homeFooter = find.byKey(Key("HomeFooter"));

      expect(homeWidget, findsOneWidget);
      expect(homeNavigation, findsOneWidget);
      expect(homeContent, findsOneWidget);
      expect(homeFooter, findsOneWidget);
    },
  );
  testWidgets(
    'Sign In Page Redirect',
    (WidgetTester tester) async {
      // Info: Testing if sign in button redirects to sign in page
      final widget = momentum();
      await tester.pumpWidget(widget);
      await tester.pumpAndSettle();

      final signInButton = find.byKey(Key("SignInButton"));

      expect(signInButton, findsOneWidget);
      await tester.tap(signInButton);
      await tester.pumpAndSettle();
      final logInView = find.byKey(Key("LogInView"));
      expect(logInView, findsOneWidget);
    },
  );

  testWidgets(
    'Register Organisation Page Redirect',
    (WidgetTester tester) async {
      // Info: Testing if register button redirects to register organisation page
      final widget = momentum();
      await tester.pumpWidget(widget);
      await tester.pumpAndSettle();

      final registerButton = find.byKey(Key("RegisterButton"));

      expect(registerButton, findsOneWidget);
      await tester.tap(registerButton);
      await tester.pumpAndSettle();
      final createOrganisationView = find.byKey(Key("CreateOrganisationView"));
      expect(createOrganisationView, findsOneWidget);
    },
  );
}
