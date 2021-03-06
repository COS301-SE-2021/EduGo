import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mobile/src/Components/Nav/Bottom/Controller/BottomBarController.dart';
import 'package:mobile/src/Components/User/Controller/UserController.dart';
import 'package:mobile/src/Components/User/Service/UserService.dart';
import 'package:mobile/src/Pages/CanvasPage/View/CanvasCodePage.dart';
import 'package:mobile/src/Pages/CanvasPage/View/CanvasPage.dart';
import 'package:mobile/src/Pages/DetectMarkerPage/View/DetectMarkerPage.dart';
import 'package:mobile/src/Pages/GradesPage/Controller/GradeLessonPageController.dart';
import 'package:mobile/src/Pages/GradesPage/Controller/GradesController.dart';
import 'package:mobile/src/Pages/GradesPage/Controller/GradesQuizPageController.dart';
import 'package:mobile/src/Pages/GradesPage/View/GradesLessonPage.dart';
import 'package:mobile/src/Pages/GradesPage/View/GradesQuizPage.dart';
import 'package:mobile/src/Pages/GradesPage/View/GradesQuizSpecificsPage.dart';
import 'package:mobile/src/Pages/GradesPage/View/GradesSubjectPage.dart';
import 'package:mobile/src/Pages/HomePage/View/HomePage.dart';
import 'package:mobile/src/Pages/HomePage/Controller/HomeController.dart';
import 'package:mobile/src/Pages/HomePage/Service/HomeService.dart';
import 'package:mobile/src/Pages/LessonsPage/Controller/LessonInformationController.dart';
import 'package:mobile/src/Pages/LessonsPage/View/LessonInformationPage.dart';
import 'package:mobile/src/Pages/LessonsPage/View/LessonsPage.dart';
import 'package:mobile/src/Pages/LoginPage/View/LoginPage.dart';
import 'package:mobile/src/Pages/OrganisationsPage/View/OrganisationsPage.dart';
import 'package:mobile/src/Pages/PreferencesPage/View/PreferencesPage.dart';
import 'package:mobile/src/Pages/QuizPage/Controller/QuizzesPageController.dart';
import 'package:mobile/src/Pages/QuizPage/View/QuizCompletedView.dart';
import 'package:mobile/src/Pages/QuizPage/View/QuizPageView.dart';
import 'package:mobile/src/Pages/QuizPage/View/QuizzesPageView.dart';
import 'package:mobile/src/Pages/RegistrationPage/View/RegistrationPage.dart';
import 'package:mobile/src/Pages/RegistrationPage/View/RegistrationVerificationPage.dart';
import 'package:mobile/src/Pages/SettingsPage/View/SettingsPage.dart';
import 'package:mobile/src/Pages/SubjectsPage/View/SubjectsPage.dart';
import 'package:mobile/src/Pages/LessonsPage/Controller/LessonController.dart';
import 'package:mobile/src/Pages/SubjectsPage/Controller/SubjectController.dart';
import 'package:mobile/src/Pages/VirtualEntityPage/View/ARWindow.dart';
import 'package:mobile/src/Pages/VirtualEntityPage/View/VirtualEntityPage.dart';
import 'package:momentum/momentum.dart';

void main() {
  //when mock=false it uses api calls. when mock=true, it uses mock data

  //* Wrapping the App in a Momentum instance for state and MVC Management
  runApp(momentum(mock: false));
  //PaintingBinding.instance!.imageCache!.clear();
}

Momentum momentum({bool mock = false}) {
  return Momentum(
    child: MyApp(),
    controllers: [
      //*list of controller instances that can be reused down the tree multiple times.
      //Controllers are used to update the models. Doing so rebuilds the widgets (view).
      // QuizController(mock: false),
      // QuestionPageController(mock: mock),
      LessonsController(mock: mock),
      SubjectsController(mock: mock),
      GradesController(mock: mock),
      BottomBarController(),
      UserController(mock: mock),
      HomeController(mock: mock),
      QuizzesPageController(),
      LessonInformationController(),
      GradeLessonPageController(),
      GradesQuizPageController()
    ],
    services: [
      UserApiService(), 
      HomeService(),
      MomentumRouter([
        LoginPage(), //
        LessonsPage(),
        LessonInformationPage(),
        VirtualEntityView(),
        ARWindow(),
        DetectMarkerPage(),
        GradesSubjectPage(),
        HomePage(Key('homePageKey')),
        OrganisationsPage(),
        PreferencesPage(),
        QuizzesPageView(),
        QuizPageView(), 
        QuizCompletedView(),
        RegistrationPage(Key('registrationPageKey')),
        RegistrationVerificationPage(Key('registration_verification')),
        SettingsPage(),
        SubjectsPage(),
        CanvasCodePage(),
        CanvasPage(),
        GradesLessonPage(),
        GradesQuizPage(),
        GradesQuizSpecificsPage()
      ]),
    ],
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EduGo', debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primaryColor: Color.fromARGB(255, 97, 211, 87),
          primarySwatch: Colors.blue,
          fontFamily: "Montserrat"),
      //Get the active widget from the router. This is the initial widget when the app starts.
      home: MomentumRouter.getActivePage(context),
    );
  }
}
