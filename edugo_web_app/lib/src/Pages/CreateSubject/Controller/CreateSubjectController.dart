import 'package:edugo_web_app/src/Pages/EduGo.dart';
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

  Future<void> createSubject(context) async {
    var url = Uri.parse("http://34.65.226.152:8080/subject/createSubject");

    var request = new MultipartRequest(
      "POST",
      url,
    );

    request.headers["authorization"] =
        Momentum.controller<AdminController>(context).getToken();

    request.files.add(MultipartFile.fromBytes('file', _selectedFile,
        contentType: new MediaType('application', 'octet-stream'),
        filename: "file_up"));

    request.fields['title'] = model.subjectTitle;
    request.fields['grade'] = model.subjectGrade;

    await request.send().then((value) async {
      await Response.fromStream(value).then((response) {
        MomentumRouter.goto(context, SubjectsView);
      });
    });
  }

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

      reader.readAsDataUrl(file);
      reader.onLoadEnd.listen((e) async {
        _handleResult(reader.result);
        filename = file.name;

        BlobImage blobImage = new BlobImage(file, name: file.name);
        final image = NetworkImage(blobImage.url);
        model.update(subjectImage: image.url);
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
}
