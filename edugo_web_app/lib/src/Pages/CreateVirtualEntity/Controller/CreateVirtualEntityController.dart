import 'package:edugo_web_app/src/Pages/EduGo.dart';

class CreateVirtualEntityController
    extends MomentumController<CreateVirtualEntityModel> {
  @override
  CreateVirtualEntityModel init() {
    return CreateVirtualEntityModel(
      this,
    );
  }

  void inputName(String name) {
    model.setCreateVirtualEntityName(name);
  }

  void inputDescription(String description) {
    model.setCreateVirtualEntityDescription(description);
  }

  void upload3dModel(context) {
    startWebFilePicker(context);
  }

  String getName() {
    return model.getCreateVirtualEntityName();
  }

  String getDescription() {
    return model.getCreateVirtualEntityDescription();
  }

  void clearLinkTo3DModel() {
    model.clearLinkTo3DModel();
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

    var url = Uri.parse("http://34.65.226.152:8080/virtualEntity/uploadModel");

    var request = new MultipartRequest(
      "POST",
      url,
    );

    request.headers["authorization"] =
        Momentum.controller<AdminController>(context).getToken();

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
              model.setCreateVirtualEntityModelLink(linkTo3DModel);
            }
          },
        );
      },
    );
  }

  Future createVirtualEntity(context) async {
    var url = Uri.parse(
        'http://34.65.226.152:8080/virtualEntity/createVirtualEntity');
    await post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization':
            Momentum.controller<AdminController>(context).getToken()
      },
      body: jsonEncode(
        <String, dynamic>{
          "title": model.name,
          "description": model.description,
          "quiz": Momentum.controller<QuizBuilderController>(context)
              .getQuizBuilderResult()
        },
      ),
    ).then(
      (response) {
        if (response.statusCode == 200)
          MomentumRouter.goto(context, VirtualEntityStoreView);
      },
    );
  }
}
