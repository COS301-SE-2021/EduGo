import 'package:edugo_web_app/src/Pages/EduGo.dart';
import 'package:flutter/material.dart';

class CreateLessonMultiLine extends StatelessWidget {
  final String text;
  final Function onChanged;
  final Function onSubmit;
  final GlobalKey<FormState> createLessonKey;
  const CreateLessonMultiLine(
      {Key key, this.text, this.onChanged, this.onSubmit, this.createLessonKey})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: ScreenUtil().setWidth(1000),
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
          if (createLessonKey.currentState.validate()) onSubmit();
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
