import 'package:edugo_web_app/src/Components/Components.dart';
import 'package:edugo_web_app/src/Controller.dart';
import 'package:edugo_web_app/src/Model.dart';
import 'package:edugo_web_app/src/Pages/VirtualEntity/View/Widgets/VirtualEntityButton.dart';
import 'package:flutter/material.dart';
import 'package:momentum/momentum.dart';

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
                child: MomentumBuilder(
                  controllers: [VirtualEntityController],
                  builder: (context, snapshot) {
                    var counter = snapshot<VirtualEntityModel>();
                    return Text(
                      '${counter.virtualEntityName}',
                    );
                  },
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
                            Text("Entity Description"),
                            SizedBox(
                              height: 200,
                            ),
                            VirtualEntityButton(
                                text: "Add Entity to Lesson",
                                onPressed: () {
                                  Momentum.controller<VirtualEntityController>(
                                          context)
                                      .updateVirtualEntityName(
                                          "Noah the Star!!!");
                                },
                                width: 300,
                                height: 65),
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
