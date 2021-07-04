import 'package:edugo_web_app/src/Model.dart';
import 'package:momentum/momentum.dart';
import 'package:qr_flutter/qr_flutter.dart';
// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;

class VirtualEntityController extends MomentumController<VirtualEntityModel> {
  @override
  VirtualEntityModel init() {
    return VirtualEntityModel(this, virtualEntityName: "Mish the Skeleton");
  }

  void updateVirtualEntityName(String virtualEntityName) {
    model.updateVirtualEntityName(virtualEntityName: virtualEntityName);
  }

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
