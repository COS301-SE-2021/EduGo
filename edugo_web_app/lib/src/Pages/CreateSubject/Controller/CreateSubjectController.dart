import 'package:edugo_web_app/src/Pages/EduGo.dart';

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

  Future<void> createSubject(context) async {
    var url = Uri.parse("http://43e6071f3a8e.ngrok.io/subject/createSubject");

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

      reader.onLoadEnd.listen((e) async {
        _handleResult(reader.result);
        filename = file.name;
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
}
