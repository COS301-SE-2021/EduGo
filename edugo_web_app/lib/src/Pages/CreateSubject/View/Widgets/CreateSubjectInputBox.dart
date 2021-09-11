import 'package:flutter/material.dart';

class CreateSubjectInputBox extends StatelessWidget {
  final String text;
  final Function onChanged;
  final Function onSubmit;
  final GlobalKey<FormState> createSubjectKey;

  const CreateSubjectInputBox(
      {Key key,
      this.text,
      this.onChanged,
      this.createSubjectKey,
      this.onSubmit})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 370,
      height: 80,
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
        onFieldSubmitted: (value) {
          if (createSubjectKey.currentState.validate()) onSubmit();
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
