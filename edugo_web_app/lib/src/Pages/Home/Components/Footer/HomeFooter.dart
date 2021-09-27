import 'package:flutter/material.dart';

class HomeFooter extends StatelessWidget {
  HomeFooter() : super(key: Key("HomeFooter"));
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      decoration: BoxDecoration(color: Color.fromARGB(255, 97, 211, 87)),
      child: Row(
        children: <Widget>[
          Flexible(
            child: Text(
              "Design the footer as per the figma design!",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 40,
                  color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
