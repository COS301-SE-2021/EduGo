import 'package:flutter/material.dart';

import 'package:mobile/src/Pages/DetectMarkerPage/View/DetectMarkerPage.dart';
import 'package:mobile/src/Pages/GradesPage/View/GradesSubjectPage.dart';
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
    List<String> widgetOptions = <String>[
      HomePage.id,
      SubjectsPage.id,
      GradesSubjectPage.id,
      DetectMarkerPage.id,
    ];
    //selectedIndex is used to determine which tab was selected in the bottom nav
    int selectedIndex = 0;

    //bottom bar widget returned
    return BottomNavigationBar(
      //current page displayed based on the index selected
      currentIndex: selectedIndex,
      showSelectedLabels: false,
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
            Icons.library_books_rounded,
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
            Icons.checklist_rtl_outlined,
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
            Icons.center_focus_weak,
            color: Color.fromARGB(255, 97, 211, 87),
          ),
        ),
      ],
      onTap: (index) {
        setState(() {
          //update selected index based on tab selected
          selectedIndex = index;
          //display screen of selected tab
          Navigator.pushNamed(context, widgetOptions.elementAt(selectedIndex));
        });
      },
    );
  }
}
