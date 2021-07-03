//* Create Virtual Enitity Page
//  Todo : Create a virtual entity by giving it a name,description and a 3D Model

import 'package:edugo_web_app/src/Components/Components.dart';
import 'package:edugo_web_app/src/Pages/VirtualEntity/View/UpdateVirtualEntityView.dart';
import 'package:edugo_web_app/src/Pages/VirtualEntity/View/Widgets/VirtualEntityWidgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_focus_watcher/flutter_focus_watcher.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qr_flutter/qr_flutter.dart';
// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;

class CreateVirtualEntityView extends StatefulWidget {
  @override
  State<CreateVirtualEntityView> createState() =>
      _CreateVirtualEntityViewState();
}

class _CreateVirtualEntityViewState extends State<CreateVirtualEntityView> {
  bool modelVisible = false;
  bool qrVisible = true;

  @override
  Widget build(BuildContext context) {
    return FocusWatcher(
      child: PageLayout(
        child: Stack(
          children: qrVisible
              ? [
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
                              child: VirtualEntityButton(
                                  text: "Discard 3D Model",
                                  onPressed: () {
                                    setState(
                                      () {
                                        modelVisible = !modelVisible;
                                      },
                                    );
                                  },
                                  width: 200,
                                  height: 50),
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
                ]
              : [
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
                      Align(
                        alignment: Alignment.topRight,
                        child: VirtualEntityButton(
                            text: "Print QR Marker",
                            onPressed: () async {
                              final image = await QrPainter(
                                data: "https://youtube.com",
                                version: QrVersions.auto,
                                errorCorrectionLevel: QrErrorCorrectLevel.Q,
                              ).toImageData(500);
                              final blob = html.Blob([image]);
                              final url =
                                  html.Url.createObjectUrlFromBlob(blob);
                              final anchor = html.document.createElement('a')
                                  as html.AnchorElement
                                ..href = url
                                ..style.display = 'none'
                                ..download = 'qr.png';
                              html.document.body.children.add(anchor);
                              anchor.click();
                              anchor.remove();
                            },
                            width: 200,
                            height: 50),
                      ),
                      SizedBox(
                        height: ScreenUtil().setHeight(150),
                      ),
                    ],
                  ),
                  Center(
                    child: SizedBox(
                      height: 300,
                      width: 300,
                      child: QrImage(
                        data: "https://youtube.com",
                      ),
                    ),
                  )
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
      VirtualEntityInputBox(text: "Entity Name..."),
      SizedBox(
        height: 30,
      ),
      VirtualEntityMultiLine(
        text: "Entity description...",
      ),
      SizedBox(
        height: 60,
      ),
      VirtualEntityButton(
          text: "Create Virtual Entity",
          onPressed: () {},
          width: 400,
          height: 65),
    ],
  );
}

Widget desktopRightContainer(var boolean, Function onPressed) {
  return Container(
    child: !boolean
        ? Center(
            child: VirtualEntityButton(
                text: "Upload 3D Model",
                onPressed: onPressed,
                width: 350,
                height: 60),
          )
        : Viewer(),
  );
}
