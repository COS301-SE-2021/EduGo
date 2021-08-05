import 'package:edugo_web_app/src/Pages/EduGo.dart';

class VirtualEntityController extends MomentumController<VirtualEntityModel> {
  @override
  VirtualEntityModel init() {
    return VirtualEntityModel(this,
        viewBoundVirtualEntity: VirtualEntity(),
        currentVirtualEntity: VirtualEntity());
  }

//*********************************************************************************************
//*                                                                                           *
//*       Pick file from local storage and send to API and store the link to the model        *
//*                                                                                           *
//*********************************************************************************************
  void upload3DModel() {
    startWebFilePicker();
  }

  void preview3DModel() async {}

  void clearLinkTo3DModel() {
    model.setViewBoundVirtualEntity3dModelLink(virtualEntity3dModelLink: "");
  }

//! Virtual Entity Controller Helper Methods and Attributes
//*********************************************************************************************
//*                                                                                           *
//*       Pick file from local storage                                                        *
//*                                                                                           *
//*********************************************************************************************
  List<int> _selectedFile;
  Uint8List _bytesData;
  String filename = "";
  void startWebFilePicker() async {
    InputElement uploadInput = FileUploadInputElement();
    uploadInput.multiple = true;
    uploadInput.draggable = true;
    uploadInput.click();

    uploadInput.onChange.listen((e) {
      final files = uploadInput.files;
      final file = files[0];
      final reader = new FileReader();

      reader.onLoadEnd.listen((e) {
        _handleResult(reader.result);

        filename = file.name;
        send3DModelToStorage();
      });

      reader.readAsDataUrl(file);
    });
  }

  void _handleResult(Object result) {
    _bytesData = Base64Decoder().convert(result.toString().split(",").last);
    _selectedFile = _bytesData;
  }

  Future<void> send3DModelToStorage() async {
    String linkTo3DModel;

    var url = Uri.parse("http://localhost:8080/virtualEntity/uploadModel");

    var request = new MultipartRequest(
      "POST",
      url,
    );

    request.headers["authorization"] =
        "Bearer eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoxLCJpYXQiOjE2MjgxMTgxNzcsImV4cCI6MTYyODIwNDU3N30.MieJ2NRnwCkkXKge0AFGwb3QiOu_8pp2HIYCqi_Q4l38oa0vTCea-A9t0ON0ZttHWjthyoBth7bv26Qd_rtW0T_pv-mAA_NKOY6kQLbTHjH-RU3VImXSGGfuGhi-M1U3k0uZt5uFg1Z3J_mPVTWwynvLHlkAtksg6sjzcWV_EB0NdmvuxHTROhBa2xOLs5a7gEClP--4ifScVm3l1qKlpX5_8sF0rN1hXqvqCYW5jv7SVD1oPxqBwWi0kpqGTS4wS7zU8Ntax7ThU7igym1BbRJa2gXFSDRTL-lpYVfTbZ5CG3l_sOTp-AGSESzGs-g-Qd6yOlLo1zc_01yS9kH1TMM_XhPcZWpebSthE6iGu7EYr737cf8PGvfm-6ZRPWX0EMb_Kk0wrCSN5IQSwaAd4_JqIAQ7KCFu_wPjuWtYa7T26WsepF5nfMNMWcmQMriOqY5qsFMBE9YbZ36i1XjcjBuFYb-FS0NM0DM9ddCX6Mh4sR1f0bYlOXwry8s0EQkUVaDgHjUZdENRhLH-aIr_tNVOmO7_XowIlrH2BHc5zUsrv0b2T7bmbTN5I7QrC4jQXLZ0bdJeTbCR8wvjaAn94NcFbFVJgeW95GSzuCNIjpXuAxM8PWgt04UwljO28K_cm91MWLOgl24UTa3ioPP3TY8BtvIBCt2FF808Mv2TBYs";

    request.files.add(
      MultipartFile.fromBytes('file', _selectedFile,
          contentType: new MediaType('application', 'octet-stream'),
          filename: filename),
    );

    request
        .send()
        .then((result) async {
          Response.fromStream(result).then((response) async {
            if (response.statusCode == 200) {
              Map<String, dynamic> _decoded3DModel = jsonDecode(response.body);
              linkTo3DModel = _decoded3DModel['file_link'];
              model.setViewBoundVirtualEntity3dModelLink(
                  virtualEntity3dModelLink: linkTo3DModel);
            }
          });
        })
        .catchError((err) => print('error : ' + err.toString()))
        .whenComplete(() {});
  }
}


  // void updateVirtualEntityName(String virtualEntityName) {
  //   model.updateVirtualEntityName(virtualEntityName: virtualEntityName);
  // }

//***************************************************************************************
//*                                                                                     *
//*       Return a list of virtual entities to populate the virtual entity store        *
//*                                                                                     *
//***************************************************************************************
  // void getVirtualEntities(BuildContext context) {
  //   List<Widget> enitites = <Widget>[];
  //   for (int i = 0; i < 12; i++) {
  //     enitites.add(
  //       Card(
  //         elevation: 40,
  //         shape:
  //             RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
  //         shadowColor: Colors.green,
  //         child: Center(
  //           child: Column(
  //             mainAxisSize: MainAxisSize.min,
  //             children: <Widget>[
  //               ListTile(
  //                 title: Column(
  //                   children: [
  //                     Icon(
  //                       Icons.view_in_ar_outlined,
  //                       size: 60,
  //                     ),
  //                     SizedBox(
  //                       height: 30,
  //                     ),
  //                     Align(
  //                         alignment: Alignment.center,
  //                         child: Text('Mish the Skeleton',
  //                             style: TextStyle(fontSize: 22))),
  //                   ],
  //                 ),
  //                 subtitle: Column(
  //                   children: [
  //                     SizedBox(
  //                       height: 10,
  //                     ),
  //                     Align(
  //                         alignment: Alignment.center,
  //                         child: Text('Entity by: Mr TN Mafaralala')),
  //                   ],
  //                 ),
  //               ),
  //               SizedBox(
  //                 height: 30,
  //               ),
  //               TextButton(
  //                 child: const Text(
  //                   'View Entity',
  //                   style: TextStyle(
  //                       color: Color.fromARGB(255, 97, 211, 87), fontSize: 18),
  //                 ),
  //                 onPressed: () {
  //                   updateVirtualEntityName("Mish the Astronaut");
  //                   MomentumRouter.goto(context, ViewVirtualEntityView);
  //                 },
  //               ),
  //             ],
  //           ),
  //         ),
  //       ),
  //     );
  //   }
  //   model.updateVirtualEntityStore(virtualEntities: enitites);
  // }
