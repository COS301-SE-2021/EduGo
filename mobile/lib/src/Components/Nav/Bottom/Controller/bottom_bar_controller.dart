import 'package:flutter/material.dart';

//this class is used to update the view based on the tab selected. Default is the child
class BottomBarController extends StatefulWidget {
  BottomBarController();

  @override
  _BottomBarControllerState createState() => _BottomBarControllerState();
}

class _BottomBarControllerState extends State<BottomBarController> {
  //selectedIndex is used to determine which tab was selected in the bottom nav
  int selectedIndex = 0;

  //Once a tab is selected, selected page will be displayed

  @override
  Widget build(BuildContext context) {
    return Container(
      child: null,
    );
  }
}
