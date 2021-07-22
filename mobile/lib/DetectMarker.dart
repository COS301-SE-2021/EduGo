import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mobile/VirtualEntity.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class DetectMarkerView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _DetectMarkerViewState();
  }
}

class _DetectMarkerViewState extends State<DetectMarkerView> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode result;
  QRViewController controller;

  //Reassemble function that pauses the camera if platform is android and resumes the camera if platform is iOS
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller.pauseCamera();
    } else if (Platform.isIOS) {
      controller.resumeCamera();
    }
  }

  @override
  Widget build(BuildContext context) {
    // if (result != null) {
    //   print(result.code);
    //   try {
    //     VirtualEntityData data = validateMarker(result.code);
    //     Navigator.of(context).push(
    //     MaterialPageRoute(builder: 
    //       (context) => VirtualEntityView(data: data)
    //     )
    //   );
    //   }
    //   catch (err) {
    //     //TODO handle error
    //     print(err);
    //   }  
    // }

    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 5,
            child: QRView(
              key: qrKey,
              onQRViewCreated: (QRViewController controller) {
                this.controller = controller;
                controller.scannedDataStream.listen((data) {
                  // setState(() {
                  //   result = data;
                  // });
                  if (result == null) {
                    result = data;
                    try {
                      VirtualEntityData data = validateMarker(result.code);
                      Navigator.of(context).push(
                      MaterialPageRoute(builder: 
                        (context) => VirtualEntityView(data: data)
                      )
                    );
                    }
                    catch (err) {
                      //TODO handle error
                      print(err);
                    }
                  }
                });
              },
            ),
          ),
          Expanded(
            flex: 1,
            child: Center(
              child: (result != null) ? Text('Type: ${describeEnum(result.format)} Data: ${result.code}') : Text('Scan a QR code'),
            )
          )
        ]
      )
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((event) {
      setState(() {
        result = event;
      });
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}

VirtualEntityData validateMarker(String data) {
  if (
    data.length > 12 &&
    data.substring(0, 13) == "EduGo_Marker "
  ){
    //Marker has passed first two tests
    String jsonString = data.substring(13);
    try {
      Map<String, dynamic> json = jsonDecode(jsonString);
      return VirtualEntityData.fromJson(json);
    }
    catch (err) {
      //TODO: Log/Handle json decode error
    }
  }
  else {
    print('Wrong');
    throw Exception('Invalid Marker');
  }
}