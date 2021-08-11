import 'package:flutter/material.dart';

import 'package:mobile/src/Pages/DetectMarkerPage/View/DetectMarkerPage.dart';
import 'package:mobile/src/Pages/GradesPage/View/GradesPage.dart';
import 'package:mobile/src/Pages/HomePage/View/HomePage.dart';
import 'package:mobile/src/Pages/SubjectsPage/View/SubjectsPage.dart';
import 'package:momentum/momentum.dart';

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
    //selectedIndex is used to determine which tab was selected in the bottom nav
    int selectedIndex = 0;

    //bottom bar widget returned
    return BottomNavigationBar(
      type: BottomNavigationBarType.shifting,
      //current page displayed based on the index selected
      currentIndex: selectedIndex,
      showSelectedLabels: true,
      showUnselectedLabels: false,
      items: [
        BottomNavigationBarItem(
          icon: Icon(
            Icons.cottage_rounded,
            color: Colors.grey,
          ),
          label: 'HOME',
          activeIcon: Icon(
            Icons.cottage_rounded,
            color: Color.fromARGB(255, 97, 211, 87),
          ),
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.library_books_rounded,
            color: Colors.grey,
          ),
          label: 'SUBJECTS',
          activeIcon: Icon(
            Icons.cottage_rounded,
            color: Color.fromARGB(255, 97, 211, 87),
          ),
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.checklist_rtl_outlined,
            color: Colors.grey,
          ),
          label: 'GRADES',
          activeIcon: Icon(
            Icons.cottage_rounded,
            color: Color.fromARGB(255, 97, 211, 87),
          ),
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.center_focus_weak,
            color: Colors.grey,
          ),
          label: 'DETECT MARKER',
          activeIcon: Icon(
            Icons.cottage_rounded,
            color: Color.fromARGB(255, 97, 211, 87),
          ),
        ),
      ],
      onTap: (index) {
        setState(() {
          //update selected index based on tab selected
          selectedIndex = index;
          //display screen of selected tab
          MomentumRouter.goto(
            context,
            widgetOptions.elementAt(selectedIndex),
          );
        });
      },
    );
  }
}
