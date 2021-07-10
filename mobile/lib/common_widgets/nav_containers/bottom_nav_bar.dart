import 'package:flutter/material.dart';
import 'package:mobile/pages/DetectMarkerPage.dart';
import 'package:mobile/pages/GradesPage.dart';
import 'package:mobile/pages/HomePage.dart';
import 'package:mobile/pages/SubjectsPage.dart';

class Bottom_Nav_Bar extends StatefulWidget {
  Bottom_Nav_Bar({Key? key}) : super(key: key);

  @override
  _Bottom_Nav_BarState createState() => _Bottom_Nav_BarState();
}

class _Bottom_Nav_BarState extends State<Bottom_Nav_Bar> {
  //widgets (screens) based on icon selected in bottom nav bar
  int _selectedIndex = 0;
  // (Home, Subject, Grade, DetectMarker)
  List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    SubjectsPage(),
    GradesPage(),
    DetectMarkerPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: null,
    );
  }
}
