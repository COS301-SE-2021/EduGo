import 'package:flutter/material.dart';

//Imported, custom pages
import 'package:mobile/src/Pages/DetectMarkerPage/View/DetectMarkerPage.dart';
import 'package:mobile/src/Pages/GradesPage/View/GradesPage.dart';
import 'package:mobile/src/Pages/HomePage/View/HomePage.dart';
import 'package:mobile/src/Pages/LessonsPage/View/LessonsPage.dart';
import 'package:mobile/src/Pages/OrganisationsPage/View/OrganisationsPage.dart';
import 'package:mobile/src/Pages/PreferencesPage/View/PreferencesPage.dart';
import 'package:mobile/src/Pages/SettingsPage/View/SettingsPage.dart';
import 'package:mobile/src/Pages/SubjectsPage/View/SubjectsPage.dart';
import 'package:mobile/src/Pages/LessonsPage/Controller/LessonController.dart';
import 'package:mobile/src/Pages/SubjectsPage/Controller/SubjectController.dart';

//Imported packages
import 'package:momentum/momentum.dart';

void main() {
  runApp(momentum(mock: true));
}

Momentum momentum({bool mock = false}) {
  return Momentum(
    child: MyApp(),
    controllers: [
      LessonsController(mock: mock),
      SubjectsController(mock: mock)
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
          GradesPage.id: (context) => GradesPage(),
          HomePage.id: (context) => HomePage(),
          LessonsPage.id: (context) => LessonsPage(),
          OrganisationsPage.id: (context) => OrganisationsPage(),
          PreferencesPage.id: (context) => PreferencesPage(),
          SettingsPage.id: (context) => SettingsPage(),
          SubjectsPage.id: (context) => SubjectsPage(),
        });
  }
}
