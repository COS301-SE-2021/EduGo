import 'package:edugo_web_app/src/Pages/CreateVirtualEntity/Model/Data/ArModel.dart';
import 'package:edugo_web_app/src/Pages/EduGo.dart';

class CreateVirtualEntityController
    extends MomentumController<CreateVirtualEntityModel> {
  @override
  CreateVirtualEntityModel init() {
    return CreateVirtualEntityModel(this,
        modelLink: "", arModel: new ArModel());
  }

  void inputName(String name) {
    model.setCreateVirtualEntityName(name);
    ArModel modelClone = model.arModel;
    modelClone.setName(name);
    model.update(arModel: modelClone);
  }

  void inputDescription(String description) {
    model.setCreateVirtualEntityDescription(description);
    ArModel modelClone = model.arModel;
    modelClone.setDescription(description);
    model.update(arModel: modelClone);
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
    model.update(loadingModelLink: false);
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

      reader.readAsDataUrl(file);

      reader.onLoadEnd.listen((e) async {
        _handleResult(reader.result);
        filename = file.name;

        await send3DModelToStorage(
          context,
        ).then((value) {
          model.setFileName(file.name);
          model.setFileSize(file.size);
          model.setFileType(file.type);
        });
      });
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
    model.update(loadingModelLink: true);
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
              ArModel modelClone = model.arModel;
              modelClone.setFileLink(linkTo3DModel);
              model.update(arModel: modelClone);
              model.update(loadingModelLink: false);
            }
          },
        );
      },
    );
  }

  Future createVirtualEntity(context) async {
    model.update(creatingEntityLoader: true);
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
              .getQuizBuilderResult(),
          "model": model.arModel.toJson()
        },
      ),
    ).then(
      (response) {
        if (response.statusCode == 200) {
          model.clearLinkTo3DModel();
          Momentum.controller<QuizBuilderController>(context)
              .resetQuizBuilder();
          model.update(createEntityResponse: "Virtual Entity Created");
          model.update(creatingEntityLoader: false);
        } else {
          model.update(createEntityResponse: "Virtual Entity Not Created");
          model.update(creatingEntityLoader: false);
        }
      },
    );
    return model.createEntityResponse;
  }
}
