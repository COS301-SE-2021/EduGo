import 'package:flutter/material.dart';
import 'package:mobile/src/Components/Nav/Bottom/Controller/BottomBarController.dart';
import 'package:mobile/src/Components/Nav/Bottom/Model/BottomBarModel.dart';
import 'package:mobile/src/Pages/DetectMarkerPage/View/DetectMarkerPage.dart';
import 'package:mobile/src/Pages/GradesPage/View/GradesSubjectPage.dart';
import 'package:mobile/src/Pages/HomePage/View/HomePage.dart';
import 'package:mobile/src/Pages/SubjectsPage/View/SubjectsPage.dart';
import 'package:momentum/momentum.dart';
import 'package:titled_navigation_bar/titled_navigation_bar.dart';

class BottomBar extends StatefulWidget {
  BottomBar({Key? key}) : super(key: key);

  @override
  _BottomBarState createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  final List<TitledNavigationBarItem> items = [
    TitledNavigationBarItem(
        title: Text('Subjects'), icon: Icons.library_books_rounded),
    TitledNavigationBarItem(
        title: Text('Grades'), icon: Icons.checklist_rtl_outlined),
    TitledNavigationBarItem(
        title: Text('Detect marker'), icon: Icons.center_focus_weak),
  ];

  List<Type> widgetOptions = <Type>[
    SubjectsPage,
    GradesSubjectPage,
    DetectMarkerPage,
  ];

  @override
  Widget build(BuildContext context) {
    return MomentumBuilder(
        controllers: [BottomBarController],
        builder: (context, snapshot) {
          var BottomBar = snapshot<BottomBarModel>();
          return TitledBottomNavigationBar(
              items: items,
              activeColor: Color.fromARGB(255, 97, 211, 87),
              inactiveColor: Colors.black,
              curve: Curves.easeInBack,
              currentIndex: BottomBar
                  .value, // Use this to update the Bar giving a position
              onTap: (int index) {
                Momentum.controller<BottomBarController>(context)
                    .activateIcon(index, context, widgetOptions);
              });
        });
  }
}
