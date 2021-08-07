import 'package:edugo_web_app/src/Pages/EduGo.dart';

class ViewBoundVirtualEntityController
    extends MomentumController<ViewBoundVirtualEntity> {
  @override
  ViewBoundVirtualEntity init() {
    return ViewBoundVirtualEntity(
      this,
    );
  }

  void inputName(String name) {
    model.setViewBoundVirtualEntityName(name);
  }

  void inputDescription(String description) {
    model.setViewBoundVirtualEntityDescription(description);
  }

  void upload3dModel() {
    startWebFilePicker();
  }

  String getName() {
    return model.getViewBoundVirtualEntityName();
  }

  String getDescription() {
    return model.getViewBoundVirtualEntityDescription();
  }

  String get3dModelLink() {
    return model.getViewBoundVirtualEntity3dModelLink();
  }

  void clearLinkTo3DModel() {
    model.setViewBoundVirtualEntity3dModelLink("null");
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
  Future<void> startWebFilePicker() async {
    InputElement uploadInput = FileUploadInputElement();
    uploadInput.multiple = true;
    uploadInput.draggable = true;
    uploadInput.click();

    uploadInput.onChange.listen((e) {
      final files = uploadInput.files;
      final file = files[0];
      final reader = new FileReader();

      reader.onLoadEnd.listen((e) async {
        _handleResult(reader.result);
        filename = file.name;
        await send3DModelToStorage().then((value) {});
      });

      reader.readAsDataUrl(file);
    });
  }

//*********************************************************************************************
//*                                                                                           *
//*       Handle result of picking file                                                       *
//*                                                                                           *
//*********************************************************************************************
  void _handleResult(Object result) {
    _bytesData = Base64Decoder().convert(result.toString().split(",").last);
    _selectedFile = _bytesData;
  }

//*********************************************************************************************
//*                                                                                           *
//*       Send 3D Model to Amazon storage                                                     *
//*                                                                                           *
//*********************************************************************************************
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

    await request.send().then(
      (value) async {
        await Response.fromStream(value).then(
          (response) {
            if (response.statusCode == 200) {
              Map<String, dynamic> _decoded3DModel = jsonDecode(response.body);
              linkTo3DModel = _decoded3DModel['file_link'];
              model.setViewBoundVirtualEntity3dModelLink(linkTo3DModel);
            }
          },
        );
      },
    );
  }
}
