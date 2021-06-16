import 'package:edugo_web_app/ui/widgets/EduGoNav/DesktopNavBar.dart';
import 'package:edugo_web_app/ui/widgets/EduGoNav/TabletNavBar.dart';
import 'package:flutter/material.dart';

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

//Checks the screen size and renders the appropriate NavBar