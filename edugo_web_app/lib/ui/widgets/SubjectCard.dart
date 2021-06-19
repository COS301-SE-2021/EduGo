import 'package:flutter/material.dart';

class SubjectCard extends StatelessWidget {
  SubjectCard({
    required this.height,
    required this.width,
  });

  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Material(
      //elevation: 20,
      child: Container(
          //padding: EdgeInsets.symmetric(horizontal: 50, vertical: 50),
          height: height,
          width: width,
          //color: Color.fromRGBO(238, 240, 245, 1),
          decoration: BoxDecoration(
            color: Color.fromRGBO(238, 240, 245, 1),
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(10),
              topLeft: Radius.circular(10),
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10),
            ),
            border: Border.all(
              color: Colors.black,
              //width: 1,
              style: BorderStyle.solid,
            ),
          )),
    );
  }
}
