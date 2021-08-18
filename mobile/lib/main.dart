import 'package:flutter/material.dart';
import 'package:mobile/src/Pages/DetectMarkerPage/View/DetectMarkerPage.dart';
import 'package:mobile/src/Pages/GradesPage/Controller/GradesController.dart';
import 'package:mobile/src/Pages/GradesPage/View/GradesSubjectPage.dart';
import 'package:mobile/src/Pages/HomePage/View/HomePage.dart';
import 'package:mobile/src/Pages/OrganisationsPage/View/OrganisationsPage.dart';
import 'package:mobile/src/Pages/PreferencesPage/View/PreferencesPage.dart';
import 'package:mobile/src/Pages/SettingsPage/View/SettingsPage.dart';
import 'package:mobile/src/Pages/SubjectsPage/View/SubjectsPage.dart';
import 'package:mobile/src/Pages/LessonsPage/Controller/LessonController.dart';
import 'package:mobile/src/Pages/SubjectsPage/Controller/SubjectController.dart';
import 'package:momentum/momentum.dart';

void main() {
  //when mock=false it uses api calls. when mock=true, it uses mock data
  runApp(momentum(mock: true));
  //PaintingBinding.instance!.imageCache!.clear();
}

Momentum momentum({bool mock = true}) {
  return Momentum(
    child: MyApp(),
    controllers: [
      LessonsController(mock: false),
      SubjectsController(mock: false),
      GradesController(mock: false)
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

        //Navigate application using named routes
        initialRoute: HomePage.id,
        routes: {
          DetectMarkerPage.id: (context) => DetectMarkerPage(),
          GradesSubjectPage.id: (context) => GradesSubjectPage(),
          HomePage.id: (context) => SubjectsPage(),
          //LessonsPage.id: (context) => LessonsPage(),
          OrganisationsPage.id: (context) => OrganisationsPage(),
          PreferencesPage.id: (context) => PreferencesPage(),
          SettingsPage.id: (context) => SettingsPage(),
          SubjectsPage.id: (context) => SubjectsPage(),
        });
  }
}
