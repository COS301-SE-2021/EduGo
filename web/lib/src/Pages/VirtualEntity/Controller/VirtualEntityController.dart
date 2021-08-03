import 'package:edugo_web_app/src/Pages/EduGo.dart';

class VirtualEntityController extends MomentumController<VirtualEntityModel> {
  @override
  VirtualEntityModel init() {
    return VirtualEntityModel(this,
        virtualEntityName: "Mish the Skeleton",
        virtualEntityStore: [Text("No entities in the store")]);
  }

  void updateVirtualEntityName(String virtualEntityName) {
    model.updateVirtualEntityName(virtualEntityName: virtualEntityName);
  }

//***************************************************************************************
//*                                                                                     *
//*       Return a list of virtual entities to populate the virtual entity store        *
//*                                                                                     *
//***************************************************************************************
  void getVirtualEntities(BuildContext context) {
    List<Widget> enitites = <Widget>[];
    for (int i = 0; i < 12; i++) {
      enitites.add(
        MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            child: Material(
              borderRadius: BorderRadius.circular(10),
              elevation: 40,
              child: Container(
                padding: const EdgeInsets.all(20),
                child: const Text('Revolution, they...'),
              ),
            ),
            onTap: () {
              updateVirtualEntityName("Mish the Astronaut");
              MomentumRouter.goto(context, ViewVirtualEntityView);
            },
          ),
        ),
      );
    }
    model.updateVirtualEntityStore(virtualEntities: enitites);
  }

//*********************************************************************************************
//*                                                                                           *
//*       Pick file from local storage and send to API and store the link to the model        *
//*                                                                                           *
//*********************************************************************************************
  void upload3DModel() async {
    await startWebFilePicker();
    model.updateVirtualEntity3DModelLink(
        virtualEntity3DModelLink:
            "https://practiceucket.s3.us-east-2.amazonaws.com/Astronaut.glb");
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
      });
      reader.readAsDataUrl(file);
    });
  }

  void _handleResult(Object result) {
    _bytesData = Base64Decoder().convert(result.toString().split(",").last);
    _selectedFile = _bytesData;
  }

  Future<String> send3DModelToStorage() async {
    Future<String> linkTo3DModel;
    var url =
        Uri.parse("http://localhost:8080/virtualEntity/model/uploadModel");
    var request = new MultipartRequest("POST", url);
    request.files.add(MultipartFile.fromBytes('file', _selectedFile,
        contentType: new MediaType('application', 'octet-stream'),
        filename: filename));
    request
        .send()
        .then((result) async {
          Response.fromStream(result).then((response) async {
            if (response.statusCode == 200) {
              Map<String, dynamic> _3DModel = jsonDecode(response.body);
              linkTo3DModel = _3DModel['file_link'];
            }
          });
        })
        .catchError((err) => print('error : ' + err.toString()))
        .whenComplete(() {});
    return linkTo3DModel;
  }
}
