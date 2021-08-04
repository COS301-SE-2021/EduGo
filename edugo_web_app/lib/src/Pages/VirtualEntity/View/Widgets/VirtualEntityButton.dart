import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class VirtualEntityButton extends StatelessWidget {
  final String text;
  final Function onPressed;
  final double elevation;
  final double width;
  final double height;
  const VirtualEntityButton(
      {Key key,
      this.text,
      this.onPressed,
      this.width,
      this.elevation,
      this.height})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      elevation: elevation,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      onPressed: onPressed,
      minWidth: ScreenUtil().setWidth(width),
      height: height,
      child: Text(
        text,
        style: TextStyle(
          color: Colors.white,
        ),
      ),
      color: Color.fromARGB(255, 97, 211, 87),
      disabledColor: Color.fromRGBO(211, 212, 217, 1),
    );
  }
}