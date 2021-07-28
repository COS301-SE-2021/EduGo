import 'package:flutter/material.dart';

import 'package:mobile/src/Components/Nav/Bottom/View/bottom_bar.dart';
import 'package:mobile/src/Components/Nav/Side/View/SideBar.dart';

class MobilePageLayout extends StatelessWidget {
// wrap
  const MobilePageLayout(
    this.child,
    this.isSideBarVisible,
    this.isBottomBarVisible,
  );
  final Widget child;
  final bool isSideBarVisible;
  final bool isBottomBarVisible;

  @override
  Widget build(BuildContext context) {
    final BottomBar bottomBar = BottomBar(this);
    return Scaffold(
      drawer: Visibility(child: SideBar(), visible: isSideBarVisible),
      appBar: AppBar(
        title: Text('EduGo'),
        backgroundColor: Color.fromARGB(255, 97, 211, 87),
      ),
      backgroundColor: Colors.white,
      bottomNavigationBar:
          Visibility(child: bottomBar, visible: isBottomBarVisible),
      body:
          child, //alrights, sometimes, I want the screen only (visibles, sorted), but my bottom bar is not working. WHy
      //because when i click, the body doesn;t update
      //so how dp  get the child to update the parren't body
      //- callbacks?
      //- parameters
      //momentum itself?
    );
  }
}
