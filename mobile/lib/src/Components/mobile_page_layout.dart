import 'package:flutter/material.dart';
import 'package:mobile/src/Components/Nav/Bottom/View/BottomBarView.dart';
import 'package:momentum/momentum.dart';

import 'Nav/Side/View/SideBar.dart';

class MobilePageLayout extends StatefulWidget {
  const MobilePageLayout(this.isSideBarVisible, this.isBottomBarVisible,
      this.child, this.pageTitle);
  final Widget child;
  final bool isSideBarVisible;
  final bool isBottomBarVisible;
  final String pageTitle;
  @override
  MobilePageLayoutState createState() => MobilePageLayoutState(
      isSideBarVisible, isBottomBarVisible, child, pageTitle);
}

class MobilePageLayoutState extends State<MobilePageLayout> {
  //this layout determines the child (page content displayed) and whether or not
  //the nav bars (side and/or bottom) will be displayed.
  MobilePageLayoutState(this.isSideBarVisible, this.isBottomBarVisible,
      this.child, this.pageTitle);
  Widget child;
  bool isSideBarVisible;
  bool isBottomBarVisible;
  String pageTitle;

  @override
  Widget build(BuildContext context) {
    //bottom and side nav not displayed
    if (!isSideBarVisible & !isBottomBarVisible) {
      return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                MomentumRouter.pop(context);
              }),
          title: Text(pageTitle),
          backgroundColor: Color.fromARGB(255, 97, 211, 87),
        ),
        backgroundColor: Colors.white,
        //go to that page
        body: child,
      );
    }

    //only side bar displayed
    if (isSideBarVisible & !isBottomBarVisible) {
      return Scaffold(
        drawer: SideBar(),
        appBar: AppBar(
          title: Text(pageTitle),
          backgroundColor: Color.fromARGB(255, 97, 211, 87),
        ),
        backgroundColor: Colors.white,
        body: child,
      );
    }

    //only bottom bar displayed
    if (!isSideBarVisible & isBottomBarVisible) {
      return Scaffold(
        appBar: AppBar(
          title: Text(pageTitle),
          backgroundColor: Color.fromARGB(255, 97, 211, 87),
        ),
        backgroundColor: Colors.white,
        body: child,
        bottomNavigationBar: new BottomBar(),
      );
    }

    //both bottom and side nav displayed
    return Scaffold(
      drawer: SideBar(),
      appBar: AppBar(
        title: Text(pageTitle),
        backgroundColor: Color.fromARGB(255, 97, 211, 87),
      ),
      backgroundColor: Colors.white, //go to that page
      body: child,
      bottomNavigationBar: new BottomBar(),
    );
  }
}

//stateful
//function that updayes
//call
