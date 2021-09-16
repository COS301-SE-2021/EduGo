import 'package:edugo_web_app/src/Components/Components.dart';
import 'package:edugo_web_app/src/Pages/VirtualEntity/View/Widgets/VirtualEntityWidgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DesktopRightContainer extends StatefulWidget {
  @override
  State<DesktopRightContainer> createState() => _DesktopRightContainerState();
}

class _DesktopRightContainerState extends State<DesktopRightContainer> {
  bool modelVisible = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil().setWidth(230),
      child: !modelVisible
          ? Center(
              child: VirtualEntityButton(
                  elevation: 40,
                  text: "Upload 3D Model",
                  onPressed: () {
                    setState(() {
                      modelVisible = !modelVisible;
                    });
                  },
                  width: ScreenUtil().setWidth(400),
                  height: 60),
            )
          : Column(
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: VirtualEntityButton(
                      text: "Discard 3D Model",
                      onPressed: () {
                        setState(
                          () {
                            modelVisible = !modelVisible;
                          },
                        );
                      },
                      width: ScreenUtil().setWidth(200),
                      height: 50),
                ),
                Viewer(),
              ],
            ),
    );
  }
}
