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
    //does not display both side bar and bottom bar
    if (!isSideBarVisible && !isBottomBarVisible) {
      return child;
    }

    //display only bottom bar
    if (!isSideBarVisible && isBottomBarVisible) {
      return BottomBar();
    }

    //display only side bar
    if (isSideBarVisible && !isBottomBarVisible) {
      return SideBar();
    }

    //display both side bar and bottom bar
    return SideBar();
  }
}
