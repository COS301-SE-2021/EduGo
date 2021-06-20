import 'dart:html' as html;
import 'dart:typed_data';
import 'dart:convert';
import 'package:http_parser/http_parser.dart';
import 'package:http/http.dart' as http;
import 'package:edugo_web_app/ui/widgets/EduGoContainer.dart';
import 'package:edugo_web_app/ui/widgets/EduGoPage.dart';
import 'package:edugo_web_app/ui/widgets/input_fields/EduGoInput.dart';
import 'package:edugo_web_app/ui/widgets/input_fields/EduGoMultiLineInput.dart';
import 'package:edugo_web_app/ui/widgets/viewer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_focus_watcher/flutter_focus_watcher.dart';

class CreateVirtualEntityPage extends StatefulWidget {
  @override
  State<CreateVirtualEntityPage> createState() =>
      _CreateVirtualEntityPageState();
}

class _CreateVirtualEntityPageState extends State<CreateVirtualEntityPage> {
  //file Upload
  List<int> _selectedFile;
  Uint8List _bytesData;
  String modelUrl = "";

  startWebFilePicker() async {
    html.InputElement uploadInput = html.FileUploadInputElement();
    uploadInput.multiple = true;
    uploadInput.draggable = true;
    uploadInput.click();

    uploadInput.onChange.listen((e) {
      final files = uploadInput.files;
      final file = files[0];
      final reader = new html.FileReader();

      reader.onLoadEnd.listen((e) {
        _handleResult(reader.result);
      });
      reader.readAsDataUrl(file);
    });
  }

  void _handleResult(Object result) {
    setState(() {
      _bytesData = Base64Decoder().convert(result.toString().split(",").last);
      _selectedFile = _bytesData;
    });
  }

  void makeRequest() async {
    var url = Uri.parse(
        "http://127.0.0.1:8000/upload_api/web/app_dev.php/api/save-file/");
    var request = new http.MultipartRequest("POST", url);
    request.files.add(http.MultipartFile.fromBytes('file', _selectedFile,
        contentType: new MediaType('application', 'octet-stream'),
        filename: "3D Model"));
    request.send().then((response) {
      setState(() {});
    });
  }

  //Interface Management variables
  bool modelContainerVisible = true;
  String viewerLinkToModel = "";
  String previewModelLink = "";
  bool modelvisible = false;
  bool enableQuizCreate = false;
  bool quizCreateContainer = false;
  bool enableAddModel = true;
  String str = "";
  @override
  Widget build(BuildContext context) {
    return FocusWatcher(
      child: EduGoPage(
        child: Stack(
          children: <Widget>[
            EduGoContainer(
              width: MediaQuery.of(context).size.width - 100,
              height: MediaQuery.of(context).size.height - 70,
              child: Column(
                children: <Widget>[
                  Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                          quizCreateContainer
                              ? "Create Quiz"
                              : "Create Virtual Entity",
                          style: TextStyle(fontSize: 25))),
                  SizedBox(
                    height: 20,
                  ),
                  modelContainerVisible
                      ? Align(
                          alignment: Alignment.topLeft,
                          child: quizCreateContainer
                              ? Column(children: <Widget>[],)
                              : Row(
                                  children: <Widget>[
                                    Container(
                                      height:
                                          MediaQuery.of(context).size.height -
                                              360,
                                      child: SingleChildScrollView(
                                        child: Column(children: <Widget>[
                                          EduGoInput(
                                              hintText: "Entity name",
                                              width: 450),
                                          SizedBox(
                                            height: 25,
                                          ),
                                          EduGoMultiLineInput(
                                            width: 450,
                                            maxLines: 3,
                                            hintText: "Entity description",
                                          ),
                                          SizedBox(
                                            height: 25,
                                          ),
                                          EduGoMultiLineInput(
                                            width: 450,
                                            maxLines: 4,
                                            hintText: viewerLinkToModel,
                                          )
                                        ]),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 120,
                                    ),
                                    Container(
                                      height:
                                          MediaQuery.of(context).size.height -
                                              360,
                                      child: Column(
                                        children: <Widget>[
                                          enableAddModel
                                              ? MaterialButton(
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  10))),
                                                  disabledColor: Color.fromRGBO(
                                                      211, 212, 217, 1),
                                                  onPressed: () {
                                                    setState(() {
                                                      modelContainerVisible =
                                                          !modelContainerVisible;
                                                      viewerLinkToModel = "";
                                                      enableAddModel = false;
                                                    });
                                                  },
                                                  minWidth: 400,
                                                  height: 60,
                                                  child: Text("Add 3D Model",
                                                      style: TextStyle(
                                                          color: Colors.white)),
                                                  color: Color.fromARGB(
                                                      255, 97, 211, 87),
                                                )
                                              : Text("QR Marker"),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          MaterialButton(
                                            disabledColor: Color.fromRGBO(
                                                211, 212, 217, 1),
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10))),
                                            onPressed: enableQuizCreate
                                                ? () {
                                                    setState(() {
                                                      quizCreateContainer =
                                                          true;
                                                    });
                                                  }
                                                : null,
                                            minWidth: 400,
                                            height: 60,
                                            child: Text("Create Quiz",
                                                style: TextStyle(
                                                    color: enableQuizCreate
                                                        ? Colors.white
                                                        : Color.fromARGB(
                                                            255, 97, 211, 87))),
                                            color: Color.fromARGB(
                                                255, 97, 211, 87),
                                          ),
                                          SizedBox(
                                            height: 50,
                                          ),
                                          MaterialButton(
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10))),
                                            onPressed: null,
                                            minWidth: 400,
                                            height: 60,
                                            child: Text("Add Virtual Entity",
                                                style: TextStyle(
                                                    color: Color.fromARGB(
                                                        255, 97, 211, 87))),
                                            color: Color.fromARGB(
                                                255, 97, 211, 87),
                                            disabledColor: Color.fromRGBO(
                                                211, 212, 217, 1),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ))
                      : Container(
                          child: Row(
                            children: [
                              Column(
                                children: <Widget>[
                                  SizedBox(
                                      width: 400,
                                      child: TextField(
                                        onChanged: (text) {
                                          previewModelLink = text;
                                        },
                                        cursorColor:
                                            Color.fromARGB(255, 97, 211, 87),
                                        decoration: InputDecoration(
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                  color: Color.fromARGB(
                                                      255, 97, 211, 87),
                                                  width: 2.0),
                                            ),
                                            border: OutlineInputBorder(),
                                            hintText: "Paste Link to 3D Model"),
                                      )),
                                  SizedBox(
                                    height: 40,
                                  ),
                                  MaterialButton(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10))),
                                    onPressed: () {
                                      setState(() {
                                        viewerLinkToModel = previewModelLink;
                                        if (viewerLinkToModel.isEmpty) {
                                          modelvisible = false;
                                        } else {
                                          modelvisible = true;
                                        }
                                      });
                                    },
                                    minWidth: 400,
                                    height: 60,
                                    child: Text("Preview 3D Model",
                                        style: TextStyle(color: Colors.white)),
                                    color: Color.fromARGB(255, 97, 211, 87),
                                  ),
                                  SizedBox(
                                    height: 40,
                                  ),
                                  MaterialButton(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10))),
                                    onPressed: modelvisible
                                        ? () {
                                            setState(() {
                                              modelContainerVisible =
                                                  !modelContainerVisible;
                                              modelvisible = !modelvisible;

                                              previewModelLink = "";
                                              enableQuizCreate = true;
                                            });
                                          }
                                        : null,
                                    minWidth: 400,
                                    height: 60,
                                    child: Text("Upload 3D Model",
                                        style: TextStyle(
                                            color: !modelvisible
                                                ? Color.fromARGB(
                                                    255, 97, 211, 87)
                                                : Colors.white)),
                                    color: Color.fromARGB(255, 97, 211, 87),
                                    disabledColor:
                                        Color.fromRGBO(211, 212, 217, 1),
                                  ),
                                  Text(str)
                                ],
                              ),
                              SizedBox(
                                width: 200,
                              ),
                              modelvisible
                                  ? Align(
                                      alignment: Alignment.topRight,
                                      child: FocusWatcher(
                                          child: viewer(
                                              linktoModel: viewerLinkToModel)))
                                  : Align(
                                      alignment: Alignment.topRight,
                                      child: Column(
                                        children: <Widget>[
                                          MaterialButton(
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10))),
                                            onPressed: () {
                                              setState(() {
                                                modelContainerVisible = true;
                                                modelvisible = false;
                                                viewerLinkToModel = "";
                                                previewModelLink = "";
                                                enableAddModel = true;
                                              });
                                            },
                                            minWidth: 300,
                                            height: 60,
                                            child: Text("Cancel",
                                                style: TextStyle(
                                                    color: Colors.white)),
                                            color: Color.fromARGB(
                                                255, 97, 211, 87),
                                            disabledColor: Color.fromRGBO(
                                                211, 212, 217, 1),
                                          ),
                                          Directionality(
                                              textDirection: TextDirection.ltr,
                                              child: SizedBox(
                                                width: 300,
                                                height: 220,
                                                child:
                                                    Container(child: Text("")),
                                              )),
                                        ],
                                      )),
                            ],
                          ),
                        )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
