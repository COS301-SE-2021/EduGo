import 'package:flutter/material.dart';
import 'package:mobile/src/Components/Nav/Bottom/View/bottom_bar.dart';

class MobileEduGoPage extends StatelessWidget {
  final Widget child;
  MobileEduGoPage({required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //todo, include side bar in app bar: https://maffan.medium.com/how-to-create-a-side-menu-in-flutter-a2df7833fdfb
      body: Stack(
        children: <Widget>[
          Flexible(
              child: FractionallySizedBox(
                  heightFactor: 1.0, widthFactor: 1.0, child: child)),
          BottomBar(),
        ],
      ),
    );
  }
}
