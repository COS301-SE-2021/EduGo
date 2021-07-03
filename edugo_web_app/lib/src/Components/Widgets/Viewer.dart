// * Custom built 3D Model viewer, for rendering 3D models in the web app

// ignore: avoid_web_libraries_in_flutter
import 'dart:html';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class Viewer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String modelview = "<html>" +
        "   <head>" +
        "        <meta charset=\"UTF-8\">" +
        "        <meta name=\"viewpoort\" content=\"width=device-width, initial-scale=1.0\">" +
        "        <script type=\"module\" src=\"https://unpkg.com/@google/model-viewer/dist/model-viewer.min.js\"></script>" +
        "        <script nomodule src=\"https://unpkg.com/@google/model-viewer/dist/model-viewer-legacy.js\"></script>" +
        "        <script type=\"module\" src=\"https://unpkg.com/@google/model-viewer/dist/model-viewer.min.js\"></script>" +
        "   </head>" +
        "<body>" +
        "" +
        "<model-viewer style='width: 100%; height: 350px;' id=\"model\" src='" +
        "https://practiceucket.s3.us-east-2.amazonaws.com/Astronaut.glb" +
        "' alt=\"A 3D model of an astronaut\" ar ar-modes=\"webxr scene-viewer quick-look\" environment-image=\"neutral\" auto-rotate camera-controls></model-viewer>" +
        "" +
        "</body>" +
        "</html>";
    // ignore: undefined_prefixed_name
    ui.platformViewRegistry.registerViewFactory(
        'edugo_model_viewer',
        (int viewId) => IFrameElement()
          ..width = '300'
          ..height = "370"
          ..src =
              "data:text/html;charset=utf-8," + Uri.encodeComponent(modelview)
          ..style.border = 'none');
    return Directionality(
      textDirection: TextDirection.ltr,
      child: SizedBox(
          width: 300,
          height: 370,
          child: HtmlElementView(viewType: 'edugo_model_viewer')),
    );
  }
}
