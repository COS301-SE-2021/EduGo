import 'package:flutter/material.dart';
import 'package:mobile/src/Components/Nav/Bottom/Model/destination.dart';
import 'package:mobile/src/Pages/DetectMarkerPage/View/DetectMarkerPage.dart';
import 'package:mobile/src/Pages/GradesPage/View/GradesPage.dart';
import 'package:mobile/src/Pages/HomePage/View/HomePage.dart';
import 'package:mobile/src/Pages/SubjectsPage/View/SubjectsPage.dart';

class DestinationView extends StatefulWidget {
  const DestinationView({Key? key, required this.destination})
      : super(key: key);

  final Destination destination;

  @override
  _DestinationViewState createState() => _DestinationViewState();
}

//todo: display destinations
//todo: change icons
class _DestinationViewState extends State<DestinationView> {
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
              Icons.cottage_rounded,
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
              Icons.cottage_rounded,
              color: Colors.grey,
              //size: 36,
            ),
            label: 'GRADES',
            activeIcon: Icon(
              Icons.cottage_rounded,
              color: Color.fromARGB(255, 97, 211, 87),
              //size: 36,
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.cottage_rounded,
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
            _selectedIndex = index;
          });
        },
      ),
      body: _widgetOptions.elementAt(_selectedIndex),
    );
  }
}
