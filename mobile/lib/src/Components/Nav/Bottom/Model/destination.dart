//This file determines the icons and labels in the bottom naviagtion bar
import 'package:flutter/material.dart';

//constructor: label, color and icon of selected tab in bottom nav
class Destination {
  const Destination(this.title, this.icon, this.color);
  final String title;
  final IconData icon;
  final Color color;
}

//list of different tabs constructed. This list allows for agile development as more icons can be added anytime.
const List<Destination> allDestinations = <Destination>[
  //todo change icons
  Destination('Home', Icons.cottage_rounded, Color.fromARGB(255, 97, 211, 87)),
  Destination(
      'Subject', Icons.cottage_rounded, Color.fromARGB(255, 97, 211, 87)),
  Destination(
      'Grades', Icons.cottage_rounded, Color.fromARGB(255, 97, 211, 87)),
  Destination(
      'DetectMarker', Icons.cottage_rounded, Color.fromARGB(255, 97, 211, 87))
];
