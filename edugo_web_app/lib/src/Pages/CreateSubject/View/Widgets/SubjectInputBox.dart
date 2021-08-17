import 'package:flutter/material.dart';

class SubjectInputBox extends StatelessWidget {
  final String text;
  final Function onChanged;
  const SubjectInputBox({Key key, this.text, this.onChanged}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 370,
      height: 60,
      child: TextField(
        onChanged: (value) {
          onChanged(value);
        },
        cursorColor: Color.fromARGB(255, 97, 211, 87),
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
                color: Color.fromARGB(255, 97, 211, 87), width: 2.0),
          ),
          border: OutlineInputBorder(),
          hintStyle: TextStyle(fontSize: 20),
          hintText: text,
        ),
      ),
    );
  }
}
