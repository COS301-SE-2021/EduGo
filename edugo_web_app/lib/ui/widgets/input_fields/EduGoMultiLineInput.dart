import 'package:flutter/material.dart';

class EduGoMultiLineInput extends StatelessWidget {
  EduGoMultiLineInput(
      {required this.hintText, required this.maxLines, required this.width});
  final String hintText;
  final double width;
  final maxLines;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: TextField(
        cursorColor: Color.fromARGB(255, 97, 211, 87),
        decoration: InputDecoration(
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                  color: Color.fromARGB(255, 97, 211, 87), width: 2.0),
            ),
            border: OutlineInputBorder(),
            hintText: hintText),
        keyboardType: TextInputType.multiline,
        maxLines: maxLines,
      ),
    );
  }
}
