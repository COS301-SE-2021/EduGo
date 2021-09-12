import 'package:flutter/material.dart';
import 'package:mobile/src/Components/Nav/Bottom/Controller/BottomBarController.dart';
import 'package:mobile/src/Components/User/Controller/UserController.dart';
import 'package:mobile/src/Components/User/Service/UserService.dart';
import 'package:mobile/src/Pages/DetectMarkerPage/View/DetectMarkerPage.dart';
import 'package:mobile/src/Pages/GradesPage/Controller/GradesController.dart';
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
      QuizController(mock: false),
      QuestionPageController(mock: mock),
      LessonsController(mock: mock),
      SubjectsController(mock: mock),
      GradesController(mock: mock),
      BottomBarController(),
      UserController(mock: mock),
      HomeController(mock: mock)
    ],
    services: [
      UserApiService(), HomeService(),
      //MomentumRouter is a built-in MomentumService for persistent navigation system: https://www.xamantra.dev/momentum/#/router
      MomentumRouter([
        LoginPage(), //
        LessonsPage(),
        LessonInformationPage(
          lessonTitle: 'Algebra',
          lessonID: 1,
          lessonDescription: 'Introduction to Basic Algebra',
          lessonVirtualEntity: [],
        ),

        DetectMarkerPage(),
        GradesSubjectPage(),
        HomePage(Key('homePageKey')),
        OrganisationsPage(),
        PreferencesPage(),
        QuestionPage(),
        QuizPage(),
        QuizResultView(),
        RegistrationPage(Key('registrationPageKey')), //
        RegistrationVerificationPage(Key('registration_verification')), //
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

//admin
//eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoxLCJpYXQiOjE2Mjk3ODgzMTEsImV4cCI6MTYyOTg3NDcxMX0.o7_1RT-Dww-UzULi4UQ32YWU49pv4V-hB6tRfnbSdAfuu05oZISA42q4YAzVfbkju6-YWcSeVjCGv0aCCYTlApcXUvLbXL3c5ctJf5V6A9be_o9aiMEpoMPpBZ_1zDSZlWRsfZMYcn9OwV7Nq2UwHeBjLN3Ck955OfwWufWJXdkUR1QNlenLRxI6h4Q9C30nmGhUTE61125qWeGLbl1yqNthOvProIIS6f5BbRk2-Dioq3tdYoCV_RKCYTvbg3eVcWS9CVgURvdArPb-K-yHj8Go4zYfLpm-vPeLyQhnW6aKdTWvK4K3ZIuXvVw8-h0PqxyxWEoABwM81Jv69pGMaHnw0e1YcdyfgZk5IJDzS24tyITBuzCg-4M3K39uqdaw-gRWo3znbL3tJNsibzyb_Uwu6vKlv-CsJU85_nKadp8zGxxmEBcPxWw2JawGNf_XQC6F0hk7Pi2HO2VZt-e3hrKj9AE6kvYIUOPMwJVw_vd-F8OcO2lM0trBPElUjV55vBiFpkeicXwIcJTeRpiRsOeRU1FGzjdatyD4N4ji7POJAqCMU82XDEZQl3Pq6FT8woYFcEydik_wxRTUE1dw3y7EM8VXJ7oeVlTDeY0dKJH8thEvTLy60I3xfXjtgCfQSeeYvVXoCl7O7oroPlsN5iqn8Icf1x2B6RPLwxrDeZE
//{ "username":"jamesp", "password": "test"}

//student
//eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjo4LCJpYXQiOjE2Mjk3ODc2NTQsImV4cCI6MTYyOTg3NDA1NH0.XeB_Zt4vcP_gv0wm0Yd6Ho3irrwSyusF3W1_AVjbq1sgXRD7JpLi8QRJ3aVjOpqExB2Y-bYCVLBUHem0R4kUb_7WiUC9crx51vx60jPFFCSMgHjDo2LQwfV-Icw4_121N3_Xk0ieaL63nmqhztWR8GdNga2kfxBb0VI46HvIWO_LihP6YZbW5dovkCMwMInxVWL0LE1xPVNPEDKeQ62O70AsyLzPF0dx4JSbgxjzphJTJPNJiLtdJB0Ap3UgOk7oIgBvWSnwUK740nLD7BLPZIQRgjWdsODK598cNlzoANxorkx1iMqaDDG2pidTGLenaESlC8OvDswc6saK2--JZ-hWkSq6zPx54KtK4j__bZA8ZcRb5_-Q1_7e59PvS4N64LK6d1YG5Mpjr0yCAu8x-yljkcQe74D0MyPctDJeXrONDDGhp6nuzXI5RRGUQWwjNOpuuUxEPOkMK_e8GbZUnATl-OIyW5hlhnf-4Kt2BVWlAChsQyFfRjRU39Hv86ESOsDcDGFyaEJRmWnUKqMPga0YIuxGXEYMQeLrnaYrNk1NkDHS18w6RE8UPuj6YG03td10FPR8TDkNBmPsB69tWVNq38fGNBgfDjmKyNBB6JXfWnBTnTKyAtx-K0Y3fO1Fqa5TRe73Qmm8paYuL1ygVt-RhLXZo8W_EKuphQM0lm8
//{ "username":"test1", "password": "Mish@1234"}