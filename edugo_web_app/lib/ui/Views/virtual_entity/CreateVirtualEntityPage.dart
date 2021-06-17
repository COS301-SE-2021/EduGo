import 'package:edugo_web_app/ui/widgets/EduGoContainer.dart';
import 'package:edugo_web_app/ui/widgets/EduGoPage.dart';
import 'package:edugo_web_app/ui/widgets/input_fields/EduGoInput.dart';
import 'package:edugo_web_app/ui/widgets/input_fields/EduGoMultiLineInput.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_cube/flutter_cube.dart';

class CreateVirtualEntityPage extends StatefulWidget {
  @override
  State<CreateVirtualEntityPage> createState() =>
      _CreateVirtualEntityPageState();
}

class _CreateVirtualEntityPageState extends State<CreateVirtualEntityPage> {
  bool modelContainerVisible = true;
  bool modelVisible = true;
  String str = "";
  FilePickerResult? result = null;
  @override
  Widget build(BuildContext context) {
    return EduGoPage(
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
                  height: 45,
                ),
                modelContainerVisible
                    ? Align(
                        alignment: Alignment.topLeft,
                        child: Row(
                          children: <Widget>[
                            Container(
                              height: MediaQuery.of(context).size.height - 360,
                              child: SingleChildScrollView(
                                child: Column(children: <Widget>[
                                  EduGoInput(
                                      hintText: "Entity name", width: 450),
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
                                    hintText: "Quiz information",
                                  )
                                ]),
                              ),
                            ),
                            SizedBox(
                              width: 120,
                            ),
                            Container(
                              height: MediaQuery.of(context).size.height - 360,
                              child: Column(
                                children: <Widget>[
                                  MaterialButton(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10))),
                                    disabledColor:
                                        Color.fromRGBO(211, 212, 217, 1),
                                    onPressed: () {
                                      setState(() {
                                        modelContainerVisible =
                                            !modelContainerVisible;
                                      });
                                    },
                                    minWidth: 400,
                                    height: 60,
                                    child: Text("Add 3D Model",
                                        style: TextStyle(color: Colors.white)),
                                    color: Color.fromARGB(255, 97, 211, 87),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  MaterialButton(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10))),
                                    disabledColor:
                                        Color.fromRGBO(211, 212, 217, 1),
                                    onPressed: null,
                                    minWidth: 400,
                                    height: 60,
                                    child: Text("Generate Marker",
                                        style: TextStyle(
                                            color: Color.fromARGB(
                                                255, 97, 211, 87))),
                                    color: Color.fromARGB(255, 97, 211, 87),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  MaterialButton(
                                    disabledColor:
                                        Color.fromRGBO(211, 212, 217, 1),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10))),
                                    onPressed: null,
                                    minWidth: 400,
                                    height: 60,
                                    child: Text("Create Quiz",
                                        style: TextStyle(
                                            color: Color.fromARGB(
                                                255, 97, 211, 87))),
                                    color: Color.fromARGB(255, 97, 211, 87),
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
                            Container(
                                child: modelVisible
                                    ? Icon(
                                        Icons.add_a_photo_outlined,
                                        size: 50,
                                        color: Color.fromARGB(255, 97, 211, 87),
                                      )
                                    : Center(
                                        child: Cube(
                                          onSceneCreated: (Scene scene) {
                                            scene.world.add(Object(
                                                fileName:
                                                    result!.files.single.path));
                                          },
                                        ),
                                      ),
                                height: 300,
                                width: 400,
                                decoration: BoxDecoration(
                                  color: Color.fromRGBO(211, 212, 217, 1),
                                )),
                            SizedBox(
                              width: 100,
                            ),
                            Column(
                              children: <Widget>[
                                MaterialButton(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10))),
                                  onPressed: () async {
                                    result = null;
                                    result =
                                        await FilePicker.platform.pickFiles(
                                      type: FileType.custom,
                                      allowedExtensions: [
                                        'obj',
                                      ],
                                    );
                                    if (result != null) {
                                      setState(() {
                                        PlatformFile file =
                                            result!.files.single;
                                        str = file.path.toString();
                                        if (modelVisible == true)
                                          modelVisible = !modelVisible;
                                      });
                                    } else {
                                      // User canceled the picker
                                    }
                                  },
                                  minWidth: 400,
                                  height: 60,
                                  child: Text("Pick Model File",
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
                                  onPressed: () {
                                    setState(() {
                                      modelContainerVisible =
                                          !modelContainerVisible;
                                      modelVisible = !modelVisible;
                                    });
                                  },
                                  minWidth: 400,
                                  height: 60,
                                  child: Text("Upload 3D Model",
                                      style: TextStyle(color: Colors.white)),
                                  color: Color.fromARGB(255, 97, 211, 87),
                                ),
                                Text(str)
                              ],
                            )
                          ],
                        ),
                      )
              ],
            ),
          )
        ],
      ),
    );
  }
}
