import 'package:flutter/material.dart';

class MobilePageLayout extends StatelessWidget {
  const MobilePageLayout(
      this.child, this.isSideBarVisible, this.isBottomBarVisible);

  final Widget child;
  final bool isSideBarVisible;
  final bool isBottomBarVisible;

  @override
  Widget build(BuildContext context) {
    if (isSideBarVisible && !isBottomBarVisible) {
      //return Scaffold is side bar and child
    }

    if (!isSideBarVisible && isBottomBarVisible) {
      //return Scaffold is bottom bar and child
    }
    //return Scaffold is bottom bar, side bar and child
    return Scaffold();
  }
}
