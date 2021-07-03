import 'package:edugo_web_app/src/Components/Widgets/PageLayout.dart';
import 'package:edugo_web_app/src/Components/Widgets/Viewer.dart';
import 'package:edugo_web_app/src/Pages/VirtualEntity/View/Widgets/VirtualEntityWidgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UpdateVirtualEntityView extends StatelessWidget {
  UpdateVirtualEntityView();
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
              Spacer(),
              Align(
                alignment: Alignment.topRight,
                child: VirtualEntityButton(
                    text: "Delete Entity",
                    onPressed: () {},
                    width: 200,
                    height: 50),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.only(top: 60),
            child: ListView(
              physics: BouncingScrollPhysics(),
              padding: EdgeInsets.only(bottom: 70, left: 20, right: 20),
              children: [
                SizedBox(
                  height: 20,
                ),
                Material(
                    elevation: 40,
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                        child: VirtualEntityInputBox(
                          text: "Entity Name...",
                        ))),
                SizedBox(
                  height: 30,
                ),
                Material(
                  elevation: 40,
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                      child: VirtualEntityMultiLine(
                        text: "Description",
                      )),
                ),
                SizedBox(
                  height: 30,
                ),
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
                              VirtualEntityButton(
                                  text: "Change 3D Model",
                                  onPressed: () {},
                                  width: 400,
                                  height: 65),
                              SizedBox(
                                height: 60,
                              ),
                              VirtualEntityButton(
                                  text: "Print Marker",
                                  onPressed: () {},
                                  width: 400,
                                  height: 65)
                            ],
                          )
                        ]),
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                VirtualEntityButton(
                    text: "Update Virtual Entity",
                    onPressed: () {},
                    width: 400,
                    height: 65),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
