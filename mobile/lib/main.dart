import 'package:flutter/material.dart';
import 'package:mobile/src/Components/Nav/Bottom/View/bottom_bar.dart';
import 'package:mobile/src/Components/User/Controller/UserController.dart';
import 'package:mobile/src/Components/User/Service/UserService.dart';
import 'package:mobile/src/Pages/HomePage/Controller/HomeController.dart';
import 'package:mobile/src/Pages/HomePage/Service/HomeService.dart';
import 'package:mobile/src/Pages/LessonsPage/Controller/LessonController.dart';
import 'package:mobile/src/Pages/LoginPage/View/LoginPage.dart';
import 'package:mobile/src/Pages/SubjectsPage/Controller/SubjectController.dart';
import 'package:momentum/momentum.dart';

void main() {
  runApp(momentum(mock: true));
}

Momentum momentum({bool mock = false}) {
  return Momentum(
    child: MyApp(),
    controllers: [
      LessonsController(mock: mock),
      SubjectsController(mock: mock),
      UserController(mock: mock),
      HomeController(mock: mock)
    ],
    services: [UserApiService(), HomeService()],
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
      home: LoginPage(),
    );
  }
}
