import 'package:flutter/material.dart';

import 'Nav/Side/View/SideBar.dart';

class MobilePageLayout extends StatelessWidget {
  const MobilePageLayout(
      this.child, this.isSideBarVisible, this.isBottomBarVisible);
  final Widget child;
  final bool isSideBarVisible;
  final bool isBottomBarVisible;

  @override
  Widget build(BuildContext context) {
    if (!isSideBarVisible & !isSideBarVisible) {
      return Scaffold(
        body: child,
      );
    }
    return SideBar();
  }
}
