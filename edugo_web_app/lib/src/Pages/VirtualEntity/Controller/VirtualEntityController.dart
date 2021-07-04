import 'package:edugo_web_app/src/Model.dart';
import 'package:edugo_web_app/src/View.dart';
import 'package:flutter/material.dart';
import 'package:momentum/momentum.dart';
import 'package:qr_flutter/qr_flutter.dart';
// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;

class VirtualEntityController extends MomentumController<VirtualEntityModel> {
  @override
  VirtualEntityModel init() {
    return VirtualEntityModel(this,
        virtualEntityName: "Mish the Skeleton",
        virtualEntityStore: [Text("No entities in the store")]);
  }

  void updateVirtualEntityName(String virtualEntityName) {
    model.updateVirtualEntityName(virtualEntityName: virtualEntityName);
  }

  void getVirtualEntities(BuildContext context) {
    List<Widget> enitites = <Widget>[];
    for (int i = 0; i < 12; i++) {
      enitites.add(
        MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            child: Material(
              borderRadius: BorderRadius.circular(10),
              elevation: 40,
              child: Container(
                padding: const EdgeInsets.all(20),
                child: const Text('Revolution, they...'),
              ),
            ),
            onTap: () {
              updateVirtualEntityName("Mish the Astronaut");
              MomentumRouter.goto(context, ViewVirtualEntityView);
            },
          ),
        ),
      );
    }
    model.updateVirtualEntityStore(virtualEntities: enitites);
  }

//* take to create lesson
  void printMarker() async {
    final image = await QrPainter(
      data:
          "Cars Man!! Cars, Jokes. Music!!!!!, we'll actually get this info from the controller , dont stress ",
      version: QrVersions.auto,
      errorCorrectionLevel: QrErrorCorrectLevel.Q,
    ).toImageData(500);
    final blob = html.Blob([image]);
    final url = html.Url.createObjectUrlFromBlob(blob);
    final anchor = html.document.createElement('a') as html.AnchorElement
      ..href = url
      ..style.display = 'none'
      ..download = 'getName().png';
    html.document.body.children.add(anchor);
    anchor.click();
    anchor.remove();
  }
}
