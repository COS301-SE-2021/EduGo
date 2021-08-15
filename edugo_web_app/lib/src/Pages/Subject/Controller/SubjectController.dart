import 'package:edugo_web_app/src/Pages/EduGo.dart';

class SubjectController extends MomentumController<SubjectModel> {
  @override
  SubjectModel init() {
    return SubjectModel(this,
        viewBoundSubject: Subject(), currentSubject: Subject());
  }

  void setViewBoundSubjectTitle(String subjectTitle) {
    model.setViewBoundSubjectTitle(subjectTitle: subjectTitle);
  }

  void setViewBoundSubjectGrade(String subjectGrade) {
    model.setViewBoundSubjectGrade(subjectGrade: subjectGrade);
  }

  String getCurrentSubjectId() {
    return model.currentSubject.getSubjectId();
  }

  Future<String> createSubject(context) async {
    MomentumRouter.goto(context, SubjectsView);
    var url = Uri.parse('http://localhost:8080/subject/createSubject');

    var request = new MultipartRequest(
      "POST",
      url,
    );

    request.headers["authorization"] =
        Momentum.controller<SessionController>(context).getToken();

    request.files.add(await MultipartFile.fromBytes('file', _selectedFile,
        contentType: new MediaType('application', 'octet-stream'),
        filename: "file_up"));

    request.fields['title'] = model.viewBoundSubject.getSubjectTitle();
    request.fields['grade'] = model.viewBoundSubject.getSubjectGrade();

    await request.send().then((value) async {
      await Response.fromStream(value).then((response) {
        print(response.body);
      });
    });

    // if (response.statusCode == 200) {
    //   MomentumRouter.goto(context, SubjectsView);
    //   return "Subject Created";
    // } else {
    //   return "Subject Could not be created";
    // }
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

}
