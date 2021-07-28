import 'package:flutter/material.dart';

class BottomBar extends StatefulWidget {
  const BottomBar(this.scaffoldBody);

  final Widget scaffoldBody;

  @override
  _BottomBarState createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  @override
  Widget build(BuildContext context) {
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
          selectedIndex = index;
        });
      },
    );
  }
}
