import 'package:flutter/material.dart';
import 'package:mobile/src/Components/Nav/Bottom/Controller/BottomBarController.dart';
import 'package:mobile/src/Components/User/Controller/UserController.dart';
import 'package:mobile/src/Components/User/Service/UserService.dart';
import 'package:mobile/src/Pages/DetectMarkerPage/View/DetectMarkerPage.dart';
import 'package:mobile/src/Pages/GradesPage/Controller/GradesController.dart';
import 'package:mobile/src/Pages/GradesPage/View/GradesQuizSpecificsPage.dart';
import 'package:mobile/src/Pages/GradesPage/View/GradesSubjectPage.dart';
import 'package:mobile/src/Pages/HomePage/View/HomePage.dart';
import 'package:mobile/src/Pages/HomePage/Controller/HomeController.dart';
import 'package:mobile/src/Pages/HomePage/Service/HomeService.dart';
import 'package:mobile/src/Pages/LessonsPage/View/LessonInformationPage.dart';
import 'package:mobile/src/Pages/LessonsPage/View/LessonsPage.dart';
import 'package:mobile/src/Pages/LoginPage/View/LoginPage.dart';
import 'package:mobile/src/Pages/OrganisationsPage/View/OrganisationsPage.dart';
import 'package:mobile/src/Pages/PreferencesPage/View/PreferencesPage.dart';
import 'package:mobile/src/Pages/QuizPage/Controller/QuestionPageController.dart';
import 'package:mobile/src/Pages/QuizPage/Controller/QuizController.dart';
import 'package:mobile/src/Pages/QuizPage/View/QuestionPage.dart';
import 'package:mobile/src/Pages/QuizPage/View/QuizPage.dart';
import 'package:mobile/src/Pages/QuizPage/View/QuizResultView.dart';
import 'package:mobile/src/Pages/RegistrationPage/View/RegistrationPage.dart';
import 'package:mobile/src/Pages/RegistrationPage/View/RegistrationVerificationPage.dart';
import 'package:mobile/src/Pages/SettingsPage/View/SettingsPage.dart';
import 'package:mobile/src/Pages/SubjectsPage/View/SubjectsPage.dart';
import 'package:mobile/src/Pages/LessonsPage/Controller/LessonController.dart';
import 'package:mobile/src/Pages/SubjectsPage/Controller/SubjectController.dart';
import 'package:momentum/momentum.dart';

void main() {
  //when mock=false it uses api calls. when mock=true, it uses mock data
  runApp(momentum(mock: false));
  //PaintingBinding.instance!.imageCache!.clear();
}

Momentum momentum({bool mock = false}) {
  return Momentum(
    child: MyApp(),
    controllers: [
      QuizController(mock: false),
      QuestionPageController(mock: mock),
      //GradesQuizSpecificsPage(mock: mock),
      LessonsController(mock: mock),
      SubjectsController(mock: mock),
      GradesController(mock: mock),
      BottomBarController(),
      UserController(mock: mock),
      HomeController(mock: mock)
    ],
    services: [
      UserApiService(), HomeService(),
      //A built-in MomentumService for persistent navigation system: https://www.xamantra.dev/momentum/#/router
      MomentumRouter([
        LoginPage(),
        DetectMarkerPage(),
        GradesSubjectPage(),
        GradesQuizSpecificsPage(),
        HomePage(Key('homePageKey')),
        LessonsPage(
          title: '',
          subjectID: 0,
        ),
        OrganisationsPage(),
        PreferencesPage(),
        QuestionPage(),
        QuizPage(),
        QuizResultView(),
        RegistrationPage(Key('registrationPageKey')),
        RegistrationVerificationPage(Key('registration_verification')),
        SettingsPage(),
        SubjectsPage(),
        LessonInformationPage(
            lessonTitle: '', lessonID: 0, lessonDescription: '')
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
