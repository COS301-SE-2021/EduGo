import 'package:edugo_web_app/src/Pages/Home/View/Components/Footer/HomeDesktopFooter.dart';
import 'package:edugo_web_app/src/Pages/Home/View/Components/Footer/HomeTabletFooter.dart';
import 'package:flutter/material.dart';

class HomeFooter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth > 800) {
        return HomeDesktopFooter();
      } else
        return HomeTabletFooter();
    });
  }
}
