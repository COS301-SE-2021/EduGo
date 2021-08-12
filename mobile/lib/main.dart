import 'package:flutter/material.dart';
import 'package:mobile/src/Components/Nav/Bottom/Controller/BottomBarController.dart';
import 'package:mobile/src/Components/User/Controller/UserController.dart';
import 'package:mobile/src/Components/User/Service/UserService.dart';
import 'package:mobile/src/Pages/DetectMarkerPage/View/DetectMarkerPage.dart';
import 'package:mobile/src/Pages/GradesPage/View/GradesPage.dart';
import 'package:mobile/src/Pages/HomePage/Controller/HomeController.dart';
import 'package:mobile/src/Pages/HomePage/Service/HomeService.dart';
import 'package:mobile/src/Pages/HomePage/View/HomePage.dart';
import 'package:mobile/src/Pages/LessonsPage/View/LessonsPage.dart';
import 'package:mobile/src/Pages/LoginPage/View/LoginPage.dart';
import 'package:mobile/src/Pages/OrganisationsPage/View/OrganisationsPage.dart';
import 'package:mobile/src/Pages/PreferencesPage/View/PreferencesPage.dart';
import 'package:mobile/src/Pages/RegistrationPage/View/RegistrationPage.dart';
import 'package:mobile/src/Pages/RegistrationPage/View/RegistrationVerificationPage.dart';
import 'package:mobile/src/Pages/SettingsPage/View/SettingsPage.dart';
import 'package:mobile/src/Pages/SubjectsPage/View/SubjectsPage.dart';
import 'package:mobile/src/Pages/LessonsPage/Controller/LessonController.dart';
import 'package:mobile/src/Pages/SubjectsPage/Controller/SubjectController.dart';
import 'package:momentum/momentum.dart';

void main() {
  runApp(momentum(mock: false));
}

Momentum momentum({bool mock = false}) {
  return Momentum(
    child: MyApp(),
    controllers: [
      BottomBarController(),
      LessonsController(mock: mock),
      SubjectsController(mock: mock),
      UserController(mock: mock),
      HomeController(mock: mock)
    ],
    services: [
      UserApiService(), HomeService(),
      //A built-in MomentumService for persistent navigation system: https://www.xamantra.dev/momentum/#/router
      MomentumRouter([
        LoginPage(),
        DetectMarkerPage(),
        GradesPage(),
        HomePage(Key('homePageKey')),
        LessonsPage(),
        OrganisationsPage(),
        PreferencesPage(),
        RegistrationPage(Key('registrationPageKey')),
        RegistrationVerificationPage(Key('registration_verification')),
        SettingsPage(),
        SubjectsPage(),
      ]),
    ],
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EduGo',
      theme: ThemeData(
          primaryColor: Color.fromARGB(255, 97, 211, 87),
          primarySwatch: Colors.blue,
          fontFamily: "Montserrat"),
      //Get the active widget from the router. This is the initial widget when the app starts.
      home: MomentumRouter.getActivePage(context),
    );
  }
}
