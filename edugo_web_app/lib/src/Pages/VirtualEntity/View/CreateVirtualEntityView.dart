//* Create Virtual Enitity Page
//  Todo : Create a virtual entity by giving it a name,description and a 3D Model

import 'package:edugo_web_app/src/Components/Components.dart';
import 'package:edugo_web_app/src/Pages/VirtualEntity/View/Widgets/VirtualEntityWidgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_focus_watcher/flutter_focus_watcher.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'Components/VirtualEntityComponents.dart';

class CreateVirtualEntityView extends StatefulWidget {
  @override
  State<CreateVirtualEntityView> createState() =>
      _CreateVirtualEntityViewState();
}

class _CreateVirtualEntityViewState extends State<CreateVirtualEntityView> {
  bool modelVisible = false;

  @override
  Widget build(BuildContext context) {
    return FocusWatcher(
      child: PageLayout(
        child: Stack(children: [
          //* Title Row
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
              SizedBox(
                height: ScreenUtil().setHeight(100),
              )
            ],
          ),
          //* Content Container
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
                    DesktopLeftContainer(),
                    SizedBox(
                      width: ScreenUtil().setWidth(270),
                    ),
                    DesktopRightContainer(),
                  ],
                )
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
