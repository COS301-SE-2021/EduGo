import 'package:flutter/material.dart';

import 'package:mobile/src/Components/Nav/Bottom/View/bottom_bar.dart';
import 'package:mobile/src/Components/Nav/Side/View/SideBar.dart';

class MobilePageLayout extends StatelessWidget {
  const MobilePageLayout(
    this.child,
  );
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SideBar(),
      appBar: AppBar(
        title: Text('EduGo'),
        backgroundColor: Color.fromARGB(255, 97, 211, 87),
      ),
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomBar(),
      body: child ?? widgetOptions.elementAt(selectedIndex),
    );
  }
}
