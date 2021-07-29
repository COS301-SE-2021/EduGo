import 'package:edugo_web_app/src/Pages/EduGo.dart';
import 'package:edugo_web_app/src/Pages/VirtualEntity/View/Widgets/VirtualEntityWidgets.dart';
import 'package:flutter/material.dart';

class DesktopLeftContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 10,
          ),
          Material(
              elevation: 40,
              borderRadius: BorderRadius.circular(10),
              child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: VirtualEntityInputBox(text: "Entity Name..."))),
          SizedBox(
            height: 30,
          ),
          Material(
            elevation: 40,
            borderRadius: BorderRadius.circular(10),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: VirtualEntityMultiLine(
                text: "Entity description...",
              ),
            ),
          ),
          SizedBox(
            height: 40,
          ),
          VirtualEntityButton(
              elevation: 40,
              child: Text("Create Virtual Entity"),
              onPressed: () {
                MomentumRouter.goto(context, EducatorVirtualEntitiesView);
              },
              width: 450,
              height: 65),
        ],
      ),
    );
  }
}
