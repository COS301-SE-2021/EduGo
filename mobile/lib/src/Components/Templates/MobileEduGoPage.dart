import 'package:flutter/material.dart';

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
                  heightFactor: 0.8, widthFactor: 1.0, child: child)),
          //todo include Bottom bar
        ],
      ),
    );
  }
}
