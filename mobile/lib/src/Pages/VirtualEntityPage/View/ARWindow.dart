import 'dart:io';

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
import 'package:mobile/src/Components/VirtualEntityInfoCard.dart';
import 'package:mobile/src/Pages/DetectMarkerPage/View/DetectMarkerPage.dart';
import 'package:mobile/src/Pages/VirtualEntityPage/Controller/VirtualEntityController.dart';
import 'package:mobile/src/Pages/VirtualEntityPage/Models/VirtualEntityModels.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:vector_math/vector_math_64.dart' as Math;
import 'package:http/http.dart' as http;


class ARWindow extends StatefulWidget {
  ARWindow({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => ARWindowState();

}

class ARWindowState extends State<ARWindow> {
  ARSessionManager? arSessionManager;
  ARObjectManager? arObjectManager;
  ARAnchorManager? arAnchorManager;

  List<ARPlaneAnchor> anchors = [];
  List<ARNode> nodes = [];
  List<VirtualEntity> entities = [];
  List<Widget> cards = [];

  int entityCount = 0;
  bool tapping = false;

  double _scale = 0.4;

  @override
  Widget build(BuildContext context) {
    if (nodes.length > 0 && anchors.length == nodes.length && !tapping) {
      for (var i = 0; i < nodes.length; i++) {
        ARNode node = nodes[i];
        ARPlaneAnchor anchor = anchors[i];
        this.arObjectManager!.removeNode(node);
        this.arAnchorManager!.removeAnchor(anchor);
        node.scale = Math.Vector3(_scale, _scale, _scale);
        this.arAnchorManager?.addAnchor(anchor).then((anchored) => {
          if (anchored!) {
            this.arObjectManager?.addNode(node, planeAnchor: anchor)   
          }
        });
      }
    }

    if (entities.length > 0 && entities.length != entityCount) {
      entityCount = entities.length;
      tapping = false;
      cards = List.generate(
        entities[0].description.length,
        (index) => VirtualEntityInfoCard(description: entities[0].description[index])
      );
    }

    return Scaffold(
      body: Stack(
        children: [
          Container(
            child: ARView(
              planeDetectionConfig: PlaneDetectionConfig.horizontalAndVertical,
              onARViewCreated: onARViewCreated,
            )
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              color: Colors.green,
              height: MediaQuery.of(context).size.height / 14,
              child: Slider(
                label: 'Scale',
                min: 0.0,
                max: 1.0,
                value: _scale,
                onChanged: (value) { setState(() {
                  _scale = value;
                });}
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              color: Colors.green,
              height: MediaQuery.of(context).size.height / 3.5,
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView(
                  //physics: NeverScrollableScrollPhysics(),
                  //primary: false,
                  scrollDirection: Axis.horizontal,
                  children: cards
                )
              )
            )
          ),
        ]
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
      showWorldOrigin: false
    );

    this.arObjectManager?.onInitialize();
    this.arSessionManager?.onPlaneOrPointTap = onTap;
    this.arObjectManager?.onNodeTap = onNodeTap;
  }

  Future<ARNode> getNode() async {
    var id = await Navigator.push(
      this.context,
      MaterialPageRoute(builder: (context) => DetectMarkerPage())
    );
    VirtualEntity ve = await getVirtualEntity(id, client: http.Client());
    entities.add(ve);
    String dir = (await getApplicationDocumentsDirectory()).path;
    String link = ve.model?.fileLink ?? '';
    if (link == '') {
      throw Exception('No link found');
    }
    String filename = basename(link);
    if (!(await File('$dir/$filename').exists()))
      await download(link);
    return ARNode(
      type: NodeType.fileSystemAppFolderGLB,
      uri: filename,
      scale: Math.Vector3(_scale, _scale, _scale),
      position: Math.Vector3(0.0, 0.0, 0.0),
      rotation: Math.Vector4(1.0, 0.0, 0.0, 0.0)
    );
  }

  Future<void> onTap(List<ARHitTestResult> hitResults) async {
    ARHitTestResult singleHitTestResult = hitResults.firstWhere((element) => element.type == ARHitTestResultType.plane);

    ARPlaneAnchor newAnchor = ARPlaneAnchor(transformation: singleHitTestResult.worldTransform);
    bool didAddAnchor = await this.arAnchorManager?.addAnchor(newAnchor) ?? false;
    if (didAddAnchor) {
      this.anchors.add(newAnchor);
      ARNode newNode = await getNode();
      bool didAddNodeToAnchor = await this.arObjectManager?.addNode(newNode, planeAnchor: newAnchor) ?? false;

      if (didAddNodeToAnchor) {
        this.nodes.add(newNode);
      }
      else {
        this.arSessionManager?.onError("Adding node to anchor failed");
      }
    }
    else {
      this.arSessionManager?.onError("Adding anchor failed");
    }
  }

  Future<void> onNodeTap(List<String> nodes) async {
    if (nodes.length < 1 || nodes.length > 1) return;
    String node = nodes[0];
    int index = this.nodes.indexWhere((element) => element.name == node);
    VirtualEntity ve = entities[index];
    if (ve.description.length > 0) {
      cards = List.generate(
        ve.description.length,
        (index) => VirtualEntityInfoCard(description: ve.description[index])
      );
      tapping = true;
      setState(() {});
    }
  }
}