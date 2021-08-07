import 'package:flutter/material.dart';

class VirtualEntityMultiLine extends StatelessWidget {
  final Function onChanged;
  final String text;
  const VirtualEntityMultiLine({Key key, this.onChanged, this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 370,
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
          hintText: text,
          hintStyle: TextStyle(fontSize: 20),
        ),
        keyboardType: TextInputType.multiline,
        maxLines: 5,
      ),
    );
  }
}
