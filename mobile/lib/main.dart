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
import 'package:mobile/src/Pages/QuizPage/Controller/QuizController.dart';
import 'package:mobile/src/Pages/QuizPage/View/QuizPage.dart';
import 'package:mobile/src/Pages/RegistrationPage/View/RegistrationPage.dart';
import 'package:mobile/src/Pages/RegistrationPage/View/RegistrationVerificationPage.dart';
import 'package:mobile/src/Pages/SettingsPage/View/SettingsPage.dart';
import 'package:mobile/src/Pages/SubjectsPage/View/SubjectsPage.dart';
import 'package:mobile/src/Pages/LessonsPage/Controller/LessonController.dart';
import 'package:mobile/src/Pages/SubjectsPage/Controller/SubjectController.dart';
import 'package:momentum/momentum.dart';

void main() {
  FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.dumpErrorToConsole(details);
  };
  //when mock=false it uses api calls. when mock=true, it uses mock data
  runApp(momentum(mock: false));
  //PaintingBinding.instance!.imageCache!.clear();
}

Momentum momentum({bool mock = false}) {
  return Momentum(
    child: MyApp(),
    controllers: [
      // AnswerController(),
      QuizController(mock: false),
      //QuestionPageController(mock: mock),
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
        // QuestionPage(),
        QuizPage(lessonID: 0),
        // QuizResultView(),
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


//admin
//eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoxLCJpYXQiOjE2MzA0MTEyODUsImV4cCI6MTYzMDQ5NzY4NX0.iItlqrA-C3KlIZlpEJS3R24D0_-fTr9DYra1-xT2cvvTmW73wKZqLIM6-2ufEx7ULzWQINr063e_ypcTGGlvEE6xUThbE1FQumnozRv2O-LOILHX8dabrvMy1AQDWPCDTPPyS-qApZxBFLYF2P7u6RlGqdK39II9sAXUiPUrmQV6vJcABcxWwqenKoythKiRm0qeuYig66dN5Cug3QtTxcBCCj9m7JWFLBIXQ_1edLC0AM5fFN7cNNKjaA42k8q_YL6Ud0EYB-UrSF55dSWHAFxEZBCoaUiIkjJgReFjxtendDURWWACUpxnwiot_9b8KQsc9S15zriU5xVMsyZTB8s6pP9ok1rexN1msA3bxHgSSnik0e0ptTzQJFeGREbeQMV6sTK9Xkn4moIX7qgmiSjLXuf6kDDmFLEamOqBhDQAtoABqemjIOLWBBpSYOPCFkgT885sjHovooEGYwV3HbC1UM1kJ2t6WHwhi4eGdRhlBoh3E-M_w4LHQVs7aaivSByI8KstWyFV-EdJl1gWK-8GNst66nlwjDQkoHl3MGSc3clmTKxljUjaJjz5HywGcBo7TZIkzZtWkdIqPJpDlQulsWdf__TETL7PXJaWnvk0iYOcazCufXpokGPIIvP-0wanyRaDMgdxGe4ecwI3rfY03eQ-Ju8e_voOXtP9-_Y

//user
//eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjo4LCJpYXQiOjE2MzA0MTEzNzQsImV4cCI6MTYzMDQ5Nzc3NH0.odsn0xE5xMrr0Y7bZdw7blaA2y8mY7Ds5KWqLn7LOGJM1T8-ybMBW5hpIq4hYxZRxnutXKjFxnkk6btH3VbO_htWHr7ZPSuw_apfgCgS6JhpY2PBLy1UCN7UMPkKJ9PSYgnyURcMOX7RXyPlcUksZlWewGpQescYPvZZ-zoTwqUojCqZOcScfkSqCQ0ws9q29SRLC4gV5_6cvG8BMdgVfG55-bxGzzD_Ny8GbA-U9nVaJzr5g7eKYsF0NF6TtktUeCOleNEbdViFAu1_AJ8EW6pFuGUdbewU_xbdRSFxQz7VpQbF8JAo4hedEcz03JDHE4_CfCpkxiUAZQLTs8rp9_tQE-Yn7n_rPRLlvVPb8XVBNveHtCBOjy_KtGJC9e95BRJNYrXza0ZCUb9grbpgyE0plHhD_07iiofq_cT1Lso2yNjBCuXkP7Hwc_y3BgBERtildRrDqN1VGz7xdxqCGCjsCh3hlofxU5yuyPeGWSyVn5gpuCB3Hf32_xqenj1uguhTtd-TgCAihRwGQThtONzaO7rWw3WSxDi6WtMlrh_rfZjIaLNnGmwvymUt-roCqjVJidK3tGQuNv_V403FnVnUSATg9qOMtg2oFxTdKxZKyaC1PDx5Zi6x5CbBicavLdCXUlNhA9xPp68a6hp0m5bSPAdcUm9L8xF5xiGvoS0
