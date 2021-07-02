import 'package:edugo_web_app/src/Components/Navigation/NavBar.dart';
import 'package:flutter/material.dart';

class PageLayout extends StatelessWidget {
  PageLayout({
    this.child,
  });
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      fit: StackFit.expand,
      clipBehavior: Clip.antiAlias,
      children: <Widget>[
        NavBar(),
        LayoutBuilder(
          builder: (context, constraints) {
            if (constraints.maxWidth > 1199) {
              return Container(
                padding: EdgeInsets.only(top: 70, left: 150, right: 150),
                child: child,
                margin: EdgeInsets.only(left: 100, top: 100),
                width: MediaQuery.of(context).size.width - 100,
                height: MediaQuery.of(context).size.height - 100,
                decoration: BoxDecoration(
                  color: Color.fromRGBO(238, 240, 245, 1),
                ),
              );
            } else {
              return Container(
                padding: EdgeInsets.only(top: 40, left: 40, right: 40),
                child: child,
                margin: EdgeInsets.only(top: 100),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height - 100,
                decoration: BoxDecoration(
                  color: Color.fromRGBO(238, 240, 245, 1),
                ),
              );
            }
          },
        ),
      ],
    ));
  }
}
