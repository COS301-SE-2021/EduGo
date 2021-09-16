import 'package:flutter/material.dart';

import 'HomeDesktopNavBar.dart';
import 'HomeTabletNavBar.dart';

class HomeNavigation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth > 800) {
        return HomeDesktopNavbar();
      } else
        return HomeTabletNavbar();
    });
  }
}
