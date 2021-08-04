import 'package:edugo_web_app/src/Pages/EduGo.dart';

class LessonController extends MomentumController<LessonModel> {
  @override
  LessonModel init() {
    return LessonModel(this,
        viewBoundLesson: Lesson(), currentLesson: Lesson());
  }

  void setViewBoundLessonTitle(String lessonTitle) {
    model.setViewBoundLessonTitle(lessonTitle: lessonTitle);
  }

  void setViewBoundLessonDescription(String lessonDescription) {
    model.setViewBoundLessonDescription(lessonDescription: lessonDescription);
  }

  void setViewBoundLessonImageLink(String lessonDescription) {
    model.setViewBoundLessonDescription(lessonDescription: lessonDescription);
  }

  void setViewBoundLessonVirtualEntityId(String lessonVirtualEntityId) {
    model.setViewBoundLessonVirtualEntityId(
        lessonVirtualEntityID: lessonVirtualEntityId);
  }

  void setViewBoundLessonSubjectId(String lessonSubjectId) {
    model.setViewBoundLessonSubjectId(lessonSubjectID: lessonSubjectId);
  }

  void setViewBoundLessonDate(DateRangePickerSelectionChangedArgs args) {
    model.setViewBoundLessonDate(
        lessonDate: args.value.toString().substring(0, 10));
  }

  void setViewBoundLessonTime(TimeRangeResult range) {
    model.setViewBoundLessonTime(
        lessonStartTime: range.start.toString(),
        lessonEndTime: range.end.toString());
  }

  Future<String> createLesson(context) async {
    print("Lesson title : " + model.getViewBoundLessonTitle());
    print("Lesson description : " + model.getViewBoundLessonDescription());
    print("Lesson date : " + model.getViewBoundLessonDate());
    //print("Lesson start time : " + model.getViewBoundLessonStartTime());
    // print("Lesson end time : " + model.getViewBoundLessonEndTime());
    // var url = Uri.parse('http://localhost:8080/lesson/createLesson');
    // var response = await post(url, headers: {
    //   'contentType': 'application/json',
    //   'Authorization':
    //       'Bearer eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoxLCJpYXQiOjE2MjgwNzUxOTIsImV4cCI6MTYyODE2MTU5Mn0.QptEfIWGJY8KqzPQ8ZjifxKSFxhnPIj-1SRf8N-am5l5VmrJt9m1CLEBuId1xFCUAvpzPS2O7dlDiOXcBKRMs2fsUt8fRCwujkb3HbSTCFYiqNCInJCoLlE3GnLzjhbG3q2Y1wdgX9ppk1ZCA2AcOpIhWqn0HbnMoj1d43bezi3DLXuE-2Wplvyk7c1tdY589G3gZ8T5lz28x-ymTCnfvssWUtls_Yf_XFwVdZYyc3Kpf_ltWwHCZBlB8B-4QewNxkjUnB-RdNtLeUa0jR6ODebnyOiu8PftZC_eGSnmz-biJEYqJop6orBATkgBvUHQPTiq8_Di3zq-GRhiow32j12bfaq9mY-iyYXErI_1l1bY_UKnTL05FPumDWdHCIIpFXZbfdr57ySnQmW4JW1G4Ia-uH6AAbKJ0qqyC_pkvIyXwyLYym3s92u7mzp0zn176I6c5f1VGMZMieyW_0l493fsdRHafKbNDkOE49nU0AkzydcHOhjWHsd277w3VLUXaLkCIX_aeCFaRksAu_EwrHTqcwkSeHod02_hhckdGe1QZGYx_BE0ePOvZ2sutYAZZK9stYBrDjxTPAxhts5_2I-sPUrv-C6xs0q4Tmu5gR6XIH0M-ub8LIb0d9BBpBhIgHvH1J5mlAit2woRLuLLaYrphR42uK0OwXJGe8S5pno',
    // }, body: {
    //   //'title': model.viewBoundLesson.getLessonTitle(),
    //   // 'description': model.viewBoundLesson.getLessonDescription(),
    //   // 'subjectId': "1",
    //   //'date': model.viewBoundLesson.getLessonDate(),
    // });
    // if (response.statusCode == 200) {
    //   MomentumRouter.goto(context, LessonsView);
    //   return "Lesson Created";
    // } else {
    //   print(response.body);
    //   return "Lesson Could not be created";
    // }
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

//*********************************************************************************************
//*                                                                                           *
//*       Pick file from local storage and send to API and store the link to the model        *
//*                                                                                           *
//*********************************************************************************************
  // void upload3DModel() async {
  //   //await startWebFilePicker();
  //   preview3DModel();
  // }

  // void preview3DModel() async {
  //   model.updateVirtualEntity3DModelLink(
  //       virtualEntity3DModelLink:
  //           "https://practiceucket.s3.us-east-2.amazonaws.com/Astronaut.glb");
  // }

  // void clearLinkTo3DModel() {
  //   model.updateVirtualEntity3DModelLink(virtualEntity3DModelLink: "");
  // }

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
