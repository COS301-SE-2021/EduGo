import 'dart:html' as html;
import 'dart:typed_data';
import 'dart:convert';
import 'package:edugo_web_app/ui/Views/subject/SubjectsPage.dart';
import 'package:edugo_web_app/ui/Views/virtual_entity/VirtualEntityStorePage.dart';
import 'package:http_parser/http_parser.dart';
import 'package:http/http.dart' as http;
import 'package:edugo_web_app/ui/widgets/EduGoContainer.dart';
import 'package:edugo_web_app/ui/widgets/EduGoPage.dart';
import 'package:edugo_web_app/ui/widgets/viewer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_focus_watcher/flutter_focus_watcher.dart';

class CreateVirtualEntityPage extends StatefulWidget {
  @override
  State<CreateVirtualEntityPage> createState() =>
      _CreateVirtualEntityPageState();
}

class _CreateVirtualEntityPageState extends State<CreateVirtualEntityPage> {
  List<int> _selectedFile;
  Uint8List _bytesData;
  String entityName = "";
  String entityDescription = "";
  int entityLesson = 1;
  String modelUrl = "";
  var model;
  String filename = "";

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
        setState(() {
          filename = file.name;
        });
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

  void makeUploadRequest() async {
    var url =
        Uri.parse("http://localhost:8080/virtualEntity/model/uploadModel");
    var request = new http.MultipartRequest("POST", url);
    request.files.add(http.MultipartFile.fromBytes('file', _selectedFile,
        contentType: new MediaType('application', 'octet-stream'),
        filename: filename));
    request
        .send()
        .then((result) async {
          http.Response.fromStream(result).then((response) {
            if (response.statusCode == 200) {
              Map<String, dynamic> _3DModel = jsonDecode(response.body);
              setState(() {
                viewerLinkToModel = _3DModel['file_link'];
              });
            }
          });
        })
        .catchError((err) => print('error : ' + err.toString()))
        .whenComplete(() {});
  }

  Future<http.Response> saveVirtualEntity() {
    return http.post(
      Uri.parse('http://localhost:8080/virtualEntity/createVirtualEntity'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        "title": entityName,
        'lesson_id': entityLesson.toString(),
        "description": entityDescription
      }),
    );
  }

  //Interface Management variables
  bool modelContainerVisible = true;
  String viewerLinkToModel = "";
  String previewModelLink = "";
  bool modelvisible = false;
  bool enableSaveEntity = false;
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
                      child: Text("Create Virtual Entity",
                          style: TextStyle(fontSize: 25))),
                  SizedBox(
                    height: 20,
                  ),
                  modelContainerVisible
                      ? Align(
                          alignment: Alignment.topLeft,
                          child: Row(
                            children: <Widget>[
                              Container(
                                height:
                                    MediaQuery.of(context).size.height - 360,
                                child: SingleChildScrollView(
                                  child: Column(children: <Widget>[
                                    SizedBox(
                                        width: 450,
                                        child: TextField(
                                          onChanged: (text) {
                                            setState(() {
                                              entityName = text;
                                            });
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
                                              hintText: "Entity Name"),
                                        )),
                                    SizedBox(
                                      height: 25,
                                    ),
                                    SizedBox(
                                      width: 450,
                                      child: TextField(
                                        onChanged: (text) {
                                          setState(() {
                                            entityDescription = text;
                                          });
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
                                            hintText: "Entity description"),
                                        keyboardType: TextInputType.multiline,
                                        maxLines: 4,
                                      ),
                                    ),
                                  ]),
                                ),
                              ),
                              SizedBox(
                                width: 120,
                              ),
                              Container(
                                height:
                                    MediaQuery.of(context).size.height - 360,
                                child: Column(
                                  children: <Widget>[
                                    enableAddModel
                                        ? MaterialButton(
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10))),
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
                                        : Text(""),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    MaterialButton(
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10))),
                                      onPressed: () {
                                        saveVirtualEntity().then((response) => {
                                              // ignore: sdk_version_ui_as_code
                                              if (response.statusCode == 200)
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) {
                                                      return VirtualEntityStore();
                                                    }),
                                                  )
                                                }
                                            });
                                      },
                                      minWidth: 400,
                                      height: 60,
                                      child: Text("Save Virtual Entity",
                                          style:
                                              TextStyle(color: Colors.white)),
                                      color: Color.fromARGB(255, 97, 211, 87),
                                      disabledColor:
                                          Color.fromRGBO(211, 212, 217, 1),
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
                                  MaterialButton(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10))),
                                    onPressed: () {
                                      startWebFilePicker();
                                      makeUploadRequest();
                                      setState(() {
                                        if (viewerLinkToModel.isEmpty) {
                                          modelvisible = false;
                                        } else {
                                          modelvisible = true;
                                        }
                                      });
                                    },
                                    minWidth: 400,
                                    height: 60,
                                    child: Text("Upload 3D Model",
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
                                              enableSaveEntity = true;
                                            });
                                          }
                                        : null,
                                    minWidth: 400,
                                    height: 60,
                                    child: Text("Add model to entity",
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
