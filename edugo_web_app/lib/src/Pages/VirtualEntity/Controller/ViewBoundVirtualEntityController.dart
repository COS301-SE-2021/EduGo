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

  void upload3dModel(context) {
    startWebFilePicker(context);
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
  Future<void> startWebFilePicker(context) async {
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
        await send3DModelToStorage(context).then((value) {});
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
  Future<void> send3DModelToStorage(context) async {
    String linkTo3DModel;

    var url =
        Uri.parse("http://43e6071f3a8e.ngrok.io/virtualEntity/uploadModel");

    var request = new MultipartRequest(
      "POST",
      url,
    );

    request.headers["authorization"] =
        Momentum.controller<SessionController>(context).getToken();

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
              print(linkTo3DModel);
              model.setViewBoundVirtualEntity3dModelLink(linkTo3DModel);
            }
          },
        );
      },
    );
  }
}
