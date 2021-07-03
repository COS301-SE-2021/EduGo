// * Navigation builder for the web app

import 'package:flutter/material.dart';
import 'DesktopNavBar.dart';
import 'TabletNavBar.dart';

class NavBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth > 800) {
        return DesktopNavBar();
      } else
        return TabletNavBar();
    });
  }
}
