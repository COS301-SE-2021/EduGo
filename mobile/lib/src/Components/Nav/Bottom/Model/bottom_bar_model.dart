//This file stores the data: the screens displayed with their relevant content
import 'package:flutter/material.dart';

//Imported, custom pages
import 'package:mobile/src/Pages/DetectMarkerPage/View/DetectMarkerPage.dart';
import 'package:mobile/src/Pages/GradesPage/View/GradesPage.dart';
import 'package:mobile/src/Pages/HomePage/View/HomePage.dart';
import 'package:mobile/src/Pages/SubjectsPage/View/SubjectsPage.dart';

//constructor: default page is displayed. Once a tab is selected, selected page will be displayed
class BottomBarModel {
  const BottomBarModel(this.currentPageDisplayed);
  final Widget currentPageDisplayed;
}

//all the different pages that will display based on the tab selected
//this list allows for agile development as more icons can be added anytime.
List<Widget> widgetOptions = <Widget>[
  HomePage(),
  SubjectsPage(),
  GradesPage(),
  DetectMarkerPage(),
];
