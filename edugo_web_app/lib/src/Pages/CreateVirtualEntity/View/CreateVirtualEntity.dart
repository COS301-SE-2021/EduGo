// Create Virtual Enitity Page
// Todo : Create a virtual entity by giving it a name,description and a 3D Model

import 'package:edugo_web_app/src/Components/Widgets/PageLayout.dart';
import 'package:edugo_web_app/src/Components/Widgets/Viewer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_focus_watcher/flutter_focus_watcher.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CreateVirtualEntity extends StatefulWidget {
  @override
  State<CreateVirtualEntity> createState() => _CreateVirtualEntityState();
}

class _CreateVirtualEntityState extends State<CreateVirtualEntity> {
  bool modelVisible = false;

  @override
  Widget build(BuildContext context) {
    return FocusWatcher(
      child: PageLayout(
        child: Stack(
          children: [
            Row(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Create Virtual Entity",
                    style: TextStyle(
                      fontSize: 32,
                    ),
                  ),
                ),
                Spacer(),
                modelVisible
                    ? Align(
                        alignment: Alignment.topRight,
                        child: makeButton("Discard 3D Model", () {
                          setState(
                            () {
                              modelVisible = !modelVisible;
                            },
                          );
                        }, 200, 50),
                      )
                    : Container(),
                SizedBox(
                  height: ScreenUtil().setHeight(150),
                )
              ],
            ),
            Container(
              padding: EdgeInsets.only(top: 75),
              child: ListView(
                padding: EdgeInsets.only(bottom: 30),
                children: [
                  Row(
                    children: [
                      SizedBox(
                        height: ScreenUtil().setHeight(200),
                      ),
                      desktopLeftContainer(),
                      SizedBox(
                        width: ScreenUtil().setWidth(220),
                      ),
                      desktopRightContainer(
                        modelVisible,
                        () {
                          setState(() {
                            modelVisible = !modelVisible;
                          });
                        },
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget desktopLeftContainer() {
  return Container(
    child: desktopLeftContent(),
  );
}

Widget desktopLeftContent() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(
        height: 30,
      ),
      getInputBox(),
      SizedBox(
        height: 30,
      ),
      getMultiLineInputBox(),
      SizedBox(
        height: 60,
      ),
      makeButton("Create Virtual Entity", () {}, 400, 65),
    ],
  );
}

Widget desktopRightContainer(var boolean, Function onPressed) {
  return Container(
    child: !boolean
        ? Center(
            child: makeButton("Upload 3D Model", onPressed, 350, 60),
          )
        : Viewer(),
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

Widget makeButton(String text, Function onPressed, var width, var height) {
  return MaterialButton(
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
