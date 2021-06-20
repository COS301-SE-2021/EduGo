import 'package:flutter/material.dart';

class EduGoContainer extends StatelessWidget {
  EduGoContainer({
    this.child,
    this.height,
    this.width,
  });
  final Widget child;
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 20,
      child: Container(
          padding: EdgeInsets.symmetric(horizontal: 50, vertical: 50),
          height: height,
          width: width,
          child: child,
          decoration: BoxDecoration()),
    );
  }
}
