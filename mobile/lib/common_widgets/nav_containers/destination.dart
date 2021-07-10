import 'package:flutter/material.dart';

class Destination {
  const Destination(this.title, this.icon, this.color);
  final String title;
  final IconData icon;
  final Color color;
}

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
