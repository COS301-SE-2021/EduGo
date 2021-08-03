import 'package:flutter/material.dart';

class HomeDesktopFooter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      decoration: BoxDecoration(color: Color.fromARGB(255, 97, 211, 87)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text("Design the footer as per the figma design!",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 40,
                  color: Colors.white)),
        ],
      ),
    );
  }
}
