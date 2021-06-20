import 'package:edugo_web_app/ui/widgets/EduGoNav/NavBar.dart';
import 'package:flutter/material.dart';

class EduGoPage extends StatelessWidget {
  EduGoPage({
    this.child,
  });
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: <Widget>[
        NavBar(),
        Container(
          padding: EdgeInsets.only(top: 40, bottom: 40, left: 100, right: 80),
          child: child,
          margin: EdgeInsets.only(left: 100, top: 100),
          width: MediaQuery.of(context).size.width - 100,
          height: MediaQuery.of(context).size.height - 100,
          decoration: BoxDecoration(color: Color.fromRGBO(238, 240, 245, 1)),
        ),
      ],
    ));
  }
}
