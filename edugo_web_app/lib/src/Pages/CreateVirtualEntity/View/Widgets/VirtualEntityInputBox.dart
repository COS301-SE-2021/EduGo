import 'package:flutter/material.dart';

class VirtualEntityInputBox extends StatefulWidget {
  final String text;
  final double width;

  final Function onChanged;
  static var _controller = TextEditingController();
  final GlobalKey<FormState> createEntityKey;
  const VirtualEntityInputBox(
      {Key key, this.onChanged, this.width, this.text, this.createEntityKey})
      : super(key: key);

  @override
  _VirtualEntityInputBoxState createState() => _VirtualEntityInputBoxState();
}

class _VirtualEntityInputBoxState extends State<VirtualEntityInputBox> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width != null ? widget.width : 370,
      height: 75,
      child: TextFormField(
        onChanged: (value) {
          widget.onChanged(value);
        },
        validator: (value) {
          if (value.isEmpty) {
            return 'Required field, cannot be blank';
          }
          return null;
        },
        controller: VirtualEntityInputBox._controller,
        cursorColor: Color.fromARGB(255, 97, 211, 87),
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
                color: Color.fromARGB(255, 97, 211, 87), width: 2.0),
          ),
          border: OutlineInputBorder(),
          hintStyle: TextStyle(fontSize: 20),
          hintText: widget.text,
        ),
      ),
    );
  }
}
