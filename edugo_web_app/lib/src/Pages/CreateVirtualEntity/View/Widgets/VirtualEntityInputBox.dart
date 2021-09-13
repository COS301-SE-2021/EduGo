import 'package:flutter/material.dart';

class VirtualEntityInputBox extends StatelessWidget {
  final String text;
  final double width;

  final Function onChanged;
  final GlobalKey<FormState> createEntityKey;
  const VirtualEntityInputBox(
      {Key key, this.onChanged, this.width, this.text, this.createEntityKey})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width != null ? width : 370,
      height: 75,
      child: TextFormField(
        onChanged: (value) {
          onChanged(value);
        },
        validator: (value) {
          if (value.isEmpty) {
            return 'Required field, cannot be blank';
          }
          return null;
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
