import 'package:flutter/material.dart';
import 'package:mobile/src/Components/Nav/Bottom/View/bottom_bar.dart';
import 'package:mobile/src/Components/mobile_page_layout.dart';
import 'package:mobile/src/Pages/DetectMarkerPage/Controller/DetectMarkerController.dart';
import 'package:mobile/src/Pages/VirtualEntityPage/Models/VirtualEntityModels.dart';
import 'package:mobile/src/Pages/VirtualEntityPage/View/VirtualEntityPage.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class DetectMarkerPage extends StatefulWidget {
  DetectMarkerPage({Key? key}) : super(key: key);
  static String id = "detect_marker";

  @override
  _DetectMarkerPageState createState() => _DetectMarkerPageState();
}

class _DetectMarkerPageState extends State<DetectMarkerPage> {
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  @override
  Widget build(BuildContext context) {
    VirtualEntityData ve = new VirtualEntityData(ve_id: 2);

    return MobilePageLayout(
        false,
        false,
        Scaffold(
            body: Column(children: <Widget>[
          Expanded(
            flex: 5,
            child: MaterialButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                side: BorderSide(color: Colors.black),
              ),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => VirtualEntityView(data: ve)));
              },
              minWidth: 10,
              height: 60,
              child: Text(
                "Go to virtual entity",
                maxLines: 2,
                softWrap: true,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
            ),

            // child: QRView(
            //   key: qrKey,
            //   onQRViewCreated: (QRViewController controller) {
            //     this.controller = controller;

            //     controller.scannedDataStream.listen((qr) {
            //       if (result == null) {
            //         result = qr;

            //         try {
            //           VirtualEntityData data = validateMarker(result!.code);
            //           Navigator.of(context).push(MaterialPageRoute(
            //               builder: (context) => VirtualEntityView(data: data)));
            //         } catch (err) {
            //           //TODO handle error
            //         }
            //       }
            //     });
            //   },
            // ),
          ),
          Expanded(flex: 1, child: Center(child: Text('Scan a marker')))
        ])),
        'Detect Marker');
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
