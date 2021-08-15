import 'package:ar_flutter_plugin/ar_flutter_plugin.dart';
import 'package:ar_flutter_plugin/datatypes/config_planedetection.dart';
import 'package:ar_flutter_plugin/datatypes/hittest_result_types.dart';
import 'package:ar_flutter_plugin/datatypes/node_types.dart';
import 'package:ar_flutter_plugin/managers/ar_anchor_manager.dart';
import 'package:ar_flutter_plugin/managers/ar_location_manager.dart';
import 'package:ar_flutter_plugin/managers/ar_object_manager.dart';
import 'package:ar_flutter_plugin/managers/ar_session_manager.dart';
import 'package:ar_flutter_plugin/models/ar_anchor.dart';
import 'package:ar_flutter_plugin/models/ar_hittest_result.dart';
import 'package:ar_flutter_plugin/models/ar_node.dart';
import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart';

class ARWindow extends StatefulWidget {
  ARWindow({Key? key, required this.uri}) : super(key: key);

  String uri;

  @override
  State<StatefulWidget> createState() => ARWindowState(nodeUri: uri);

}

class ARWindowState extends State<ARWindow> {
  ARWindowState({required this.nodeUri});

  ARSessionManager? arSessionManager;
  ARObjectManager? arObjectManager;
  ARAnchorManager? arAnchorManager;

  ARAnchor? arAnchor;
  ARNode? arNode;

  bool tapped = false;

  String nodeUri;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ARView(
        planeDetectionConfig: PlaneDetectionConfig.horizontalAndVertical,
        onARViewCreated: onARViewCreated,
      )
    );
  }

  void onARViewCreated(
    ARSessionManager arSessionManager,
    ARObjectManager arObjectManager,
    ARAnchorManager arAnchorManager,
    ARLocationManager arLocationManager
  ) {
    this.arSessionManager = arSessionManager;
    this.arObjectManager = arObjectManager;
    this.arAnchorManager = arAnchorManager;

    this.arSessionManager?.onInitialize(
      customPlaneTexturePath: "assets/images/triangle.png",
      handleTaps: true,
      showFeaturePoints: false,
      showPlanes: true,
      showWorldOrigin: true
    );

    this.arObjectManager?.onInitialize();
    this.arSessionManager?.onPlaneOrPointTap = tap;
  }

  Future<void> tap(List<ARHitTestResult> hitResults) async {
    if (tapped) false;

    var hit = hitResults.firstWhere((element) => element.type == ARHitTestResultType.plane);

    if (hit != null) {
      var newAnchor = ARPlaneAnchor(transformation: hit.worldTransform);
      bool didAddAnchor = await this.arAnchorManager?.addAnchor(newAnchor) ?? false;
      if (didAddAnchor) {
        this.arAnchor = newAnchor;
        await showModels(anchor: newAnchor);
        tapped = true;
      }
      else this.arSessionManager?.onError("Failed to add anchor");
    }
  }

  Future<void> showModels({required ARPlaneAnchor anchor}) async {
    if (this.arNode != null) {
      this.arObjectManager?.removeNode(this.arNode!);
      this.arNode = null;
    }
    else {
      ARNode node = ARNode(
        type: NodeType.webGLB,
        uri: this.nodeUri,
        scale: Vector3(0.3, 0.3, 0.3),
        position: Vector3(0.0, 0.0, 0.0),
        rotation: Vector4(1.0, 0.0, 0.0, 0.0)
      );

      bool didAddNode = await this.arObjectManager?.addNode(node, planeAnchor: anchor) ?? false;
      this.arNode = didAddNode ? node : null;
    }
  }

}