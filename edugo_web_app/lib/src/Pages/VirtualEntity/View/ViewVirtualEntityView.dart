import 'package:edugo_web_app/src/Components/Widgets/PageLayout.dart';
import 'package:edugo_web_app/src/Components/Widgets/Viewer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ViewVirtualEntityView extends StatelessWidget {
  ViewVirtualEntityView();
  @override
  Widget build(BuildContext context) {
    return PageLayout(
      child: Stack(
        children: [
          Row(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Mish the skeleton",
                  style: TextStyle(
                    fontSize: 32,
                  ),
                ),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.only(top: 60),
            child: ListView(
              physics: BouncingScrollPhysics(),
              padding: EdgeInsets.only(left: 20, right: 20),
              children: [
                Material(
                  borderRadius: BorderRadius.circular(10),
                  elevation: 40,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 70, vertical: 40),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Viewer(),
                        Spacer(),
                        Column(
                          children: [
                            Text("Entiy Description"),
                            SizedBox(
                              height: 200,
                            ),
                            makeButton("Add Entity to Lesson", () {}, 300, 65),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Widget makeButton(String text, Function onPressed, var width, var height) {
  return MaterialButton(
    elevation: 20,
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

Widget getInputBox() {
  return SizedBox(
    width: 370,
    height: 60,
    child: TextField(
      cursorColor: Color.fromARGB(255, 97, 211, 87),
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
              color: Color.fromARGB(255, 97, 211, 87), width: 2.0),
        ),
        border: OutlineInputBorder(),
        hintStyle: TextStyle(fontSize: 20),
        hintText: "Enter entity name...",
      ),
    ),
  );
}

Widget getMultiLineInputBox() {
  return SizedBox(
    width: 370,
    child: TextField(
      cursorColor: Color.fromARGB(255, 97, 211, 87),
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
              color: Color.fromARGB(255, 97, 211, 87), width: 2.0),
        ),
        border: OutlineInputBorder(),
        hintText: "Entity description...",
        hintStyle: TextStyle(fontSize: 20),
      ),
      keyboardType: TextInputType.multiline,
      maxLines: 5,
    ),
  );
}
