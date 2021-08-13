import 'package:flutter/material.dart';
import 'package:mobile/src/Components/Nav/Bottom/View/bottom_bar.dart';
import 'Nav/Side/View/SideBar.dart';

class MobilePageLayout extends StatefulWidget {
  const MobilePageLayout(
      this.isSideBarVisible, this.isBottomBarVisible, this.child);
  final Widget child;
  final bool isSideBarVisible;
  final bool isBottomBarVisible;

  @override
  MobilePageLayoutState createState() =>
      MobilePageLayoutState(isSideBarVisible, isBottomBarVisible, child);
}

class MobilePageLayoutState extends State<MobilePageLayout> {
  //this layout determines the child (page content displayed) and whether or not
  //the nav bars (side and/or bottom) will be displayed.
  MobilePageLayoutState(
      this.isSideBarVisible, this.isBottomBarVisible, this.child);
  Widget child;
  bool isSideBarVisible;
  bool isBottomBarVisible;

  @override
  Widget build(BuildContext context) {
    print(isBottomBarVisible);
    print(isSideBarVisible);
    //bottom and side nav not displayed
    if (!isSideBarVisible & !isBottomBarVisible) {
      return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              }),
          title: Text('EduGo'),
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
          title: Text('EduGo'),
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
          title: Text('EduGo'),
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
        title: Text('EduGo'),
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
