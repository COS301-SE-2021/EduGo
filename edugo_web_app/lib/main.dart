import 'package:edugo_web_app/ui/Views/Landing/EduGoHome.dart';
import 'package:edugo_web_app/ui/Views/subject/SubjectsPage.dart';
import 'package:edugo_web_app/ui/Views/virtual_entity/CreateVirtualEntityPage.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'EduGo',
      theme: ThemeData(
          primaryColor: Color.fromARGB(255, 97, 211, 87),
          primarySwatch: Colors.blue,
          fontFamily: "Montserrat"),
      home: EduGoHome(),
    );
  }
}
