import 'package:flutter/material.dart';
import 'package:titled_navigation_bar/titled_navigation_bar.dart';
import 'package:momentum/momentum.dart';

import 'package:mobile/src/Pages/DetectMarkerPage/View/DetectMarkerPage.dart';
import 'package:mobile/src/Pages/GradesPage/View/GradesPage.dart';
import 'package:mobile/src/Pages/HomePage/View/HomePage.dart';
import 'package:mobile/src/Pages/SubjectsPage/View/SubjectsPage.dart';

class BottomBar extends StatefulWidget {
  //function that updates the scaffolds body based on the tab selected in the
  //bottom bar
  BottomBar();

  @override
  BottomBarState createState() => BottomBarState();
}

class BottomBarState extends State<BottomBar> {
  //destination options: 0.Home, 1.Subjects, 2.Grades, 3.DetectMarker

  @override
  Widget build(BuildContext context) {
    //all the different pages that will display based on the tab selected
    List<Type> widgetOptions = <Type>[
      HomePage,
      SubjectsPage,
      GradesPage,
      DetectMarkerPage,
    ];
    //_selectedIndex is used to determine which tab was selected in the bottom nav
    int _selectedIndex = 0;

    //bottom bar widget returned
    return TitledBottomNavigationBar(
        activeColor: Color.fromARGB(255, 97, 211, 87),
        inactiveColor: Colors.black,
        curve: Curves.easeInBack,
        currentIndex:
            _selectedIndex, // Use this to update the Bar giving a position
        onTap: (int index) {
          setState(() {
            _selectedIndex = index;
          });
          //display screen of selected tab
          MomentumRouter.goto(
            context,
            widgetOptions.elementAt(_selectedIndex),
          );
        },
        items: [
          TitledNavigationBarItem(
              title: Text('Home'), icon: Icons.cottage_rounded),
          TitledNavigationBarItem(
              title: Text('Subjects'), icon: Icons.library_books_rounded),
          TitledNavigationBarItem(
              title: Text('Grades'), icon: Icons.checklist_rtl_outlined),
          TitledNavigationBarItem(
              title: Text('Detect Marker'), icon: Icons.center_focus_weak),
        ]);
  }
}
//cottage_rounded Home
//library_books_rounded Subject
//checklist_rtl_outlined Grades
//center_focus_weak Detect marker
