//This file determines the icons and labels in the bottom naviagtion bar
import 'package:flutter/material.dart';
import 'package:mobile/src/Pages/DetectMarkerPage/View/DetectMarkerPage.dart';
import 'package:mobile/src/Pages/GradesPage/View/GradesPage.dart';
import 'package:mobile/src/Pages/HomePage/View/HomePage.dart';
import 'package:mobile/src/Pages/SubjectsPage/View/SubjectsPage.dart';

//constructor: label, color and icon of selected tab in bottom nav
class Destination {
  const Destination(this.child, this.icon, this.color);
  final Widget child;
  final IconData icon;
  final Color color;
}

//list of different tabs (of the bottom bar) constructed. This list allows for agile development as more icons can be added anytime.
List<Destination> allDestinations = <Destination>[
  //tabs
  Destination(HomePage(Key('homePageKey')), Icons.cottage_rounded,
      Color.fromARGB(255, 97, 211, 87)),
  Destination(SubjectsPage(), Icons.library_books_rounded,
      Color.fromARGB(255, 97, 211, 87)),
  Destination(GradesPage(), Icons.checklist_rtl_outlined,
      Color.fromARGB(255, 97, 211, 87)),
  Destination(DetectMarkerPage(), Icons.center_focus_weak,
      Color.fromARGB(255, 97, 211, 87))
];
