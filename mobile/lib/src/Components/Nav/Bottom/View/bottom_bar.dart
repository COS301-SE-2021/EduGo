import 'package:flutter/material.dart';
import 'package:mobile/src/Components/Nav/Side/View/SideBar.dart';

import 'package:mobile/src/Pages/DetectMarkerPage/View/DetectMarkerPage.dart';
import 'package:mobile/src/Pages/GradesPage/View/GradesPage.dart';
import 'package:mobile/src/Pages/HomePage/View/HomePage.dart';
import 'package:mobile/src/Pages/SubjectsPage/View/SubjectsPage.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({
    Key? key,
  }) : super(key: key);

  @override
  _BottomBarState createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  //_selectedIndex is used to determine which tab was selected in the bottom nav
  int _selectedIndex = 0;

  //all the different pages that will display based on the tab selected
  List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    SubjectsPage(),
    GradesPage(),
    DetectMarkerPage(),
  ];

  //destination options: Home, Subjects, Grades, DetectMarker
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SideBar(),
      appBar: AppBar(
        title: Text('EduGo'),
        backgroundColor: Color.fromARGB(255, 97, 211, 87),
      ),
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomNavigationBar(
        //current page displayed based on the index selected
        currentIndex: _selectedIndex,
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
            _selectedIndex = index;
          });
        },
      ),

//todo take in any page as parameter and display: make that the additional widget in list OR set defualt selected index to dipslay param child
      //go to that page
      body: _widgetOptions.elementAt(_selectedIndex),
    );
  }
}