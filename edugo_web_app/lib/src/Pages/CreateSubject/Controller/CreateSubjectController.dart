import 'package:edugo_web_app/src/Pages/EduGo.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/painting.dart'; // NetworkImage
import 'package:image_whisperer/image_whisperer.dart'; // BlobImage

class CreateSubjectController extends MomentumController<CreateSubjectModel> {
  @override
  CreateSubjectModel init() {
    return CreateSubjectModel(
      this,
    );
  }

  void setSubjectTitle(String subjectTitle) {
    model.setSubjectTitle(subjectTitle);
  }

  void setSubjectGrade(String subjectGrade) {
    model.setSubjectGrade(subjectGrade);
  }

  void clearPhoto() {
    model.update(subjectImage: "null");
  }

  Future<String> createSubject(context) async {
    model.update(createSubjectLoadController: false);
    var url =
        Uri.parse(EduGoHttpModule().getBaseUrl() + "/subject/createSubject");

    var request = new MultipartRequest(
      "POST",
      url,
    );

    request.headers["authorization"] =
        Momentum.controller<AdminController>(context).getToken();

    request.files.add(MultipartFile.fromBytes('file', _selectedFile,
        contentType: new MediaType('application', 'octet-stream'),
        filename: filename));

    request.fields['title'] = model.subjectTitle;
    request.fields['grade'] = model.subjectGrade;

    await request.send().then(
      (value) async {
        await Response.fromStream(value).then(
          (response) {
            if (response.statusCode == 200) {
              model.update(createRepsonse: "Subject created");
              model.update(subjectImage: null);
              model.update(createSubjectLoadController: true);
            } else {
              model.update(createRepsonse: "Subject not created");
              model.update(createSubjectLoadController: true);
            }
          },
        );
      },
    );
    return model.createRepsonse;
  }

  List<int> _selectedFile;
  Uint8List _bytesData;
  String filename = "";
  Future<void> startWebFilePicker(context) async {
    InputElement uploadInput = FileUploadInputElement();
    uploadInput.accept = '.png,.jpg';
    uploadInput.checkValidity();
    uploadInput.multiple = false;

    uploadInput.draggable = true;
    uploadInput.click();

    uploadInput.onChange.listen(
      (e) {
        final files = uploadInput.files;
        final file = files[0];
        final reader = new FileReader();
        if (file.type.contains('image')) {
          reader.readAsDataUrl(file);
          reader.onLoadEnd.listen(
            (e) async {
              _handleResult(reader.result);
              filename = file.name;

              BlobImage blobImage = new BlobImage(file, name: file.name);
              final image = NetworkImage(blobImage.url);
              model.update(subjectImage: image.url);
            },
          );
        } else {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return new AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                insetPadding: EdgeInsets.only(
                    top: 100, bottom: 100, left: 100, right: 100),
                title: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 15),
                      child: Icon(
                        Icons.warning_rounded,
                        color: Colors.red,
                        size: 100,
                      ),
                    ),
                    Center(
                      child: new Text(
                        'Invalid Image Uploaded',
                        style: TextStyle(fontSize: 22, color: Colors.red),
                      ),
                    ),
                  ],
                ),
                content: new SingleChildScrollView(
                  child: new ListBody(
                    children: [
                      Center(
                        child: new Text(
                          'Please upload a ".jpg" or ".png" file and try again!',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ],
                  ),
                ),
                actions: [
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: Center(
                      child: MaterialButton(
                        elevation: 20,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        minWidth: ScreenUtil().setWidth(150),
                        height: 50,
                        child: Text(
                          'Ok',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                        color: Color.fromARGB(255, 97, 211, 87),
                        disabledColor: Color.fromRGBO(211, 212, 217, 1),
                      ),
                    ),
                  ),
                ],
              );
            },
          );
        }
      },
    );
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
}
