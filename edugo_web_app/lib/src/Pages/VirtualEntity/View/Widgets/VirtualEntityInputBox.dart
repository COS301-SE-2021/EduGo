import 'package:flutter/material.dart';

class VirtualEntityInputBox extends StatelessWidget {
  final String text;
  final double width;
  final Function onChanged;
  const VirtualEntityInputBox({Key key, this.onChanged, this.width, this.text})
      : super(key: key);

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
