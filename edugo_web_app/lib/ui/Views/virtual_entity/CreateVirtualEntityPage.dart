import 'package:edugo_web_app/ui/widgets/EduGoContainer.dart';
import 'package:edugo_web_app/ui/widgets/EduGoPage.dart';
import 'package:edugo_web_app/ui/widgets/input_fields/EduGoInput.dart';
import 'package:edugo_web_app/ui/widgets/input_fields/EduGoMultiLineInput.dart';
import 'package:flutter/material.dart';

class CreateVirtualEntityPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return EduGoPage(
      child: Stack(
        children: <Widget>[
          EduGoContainer(
            width: MediaQuery.of(context).size.width - 100,
            height: MediaQuery.of(context).size.height - 100,
            child: Column(
              children: <Widget>[
                Align(
                    alignment: Alignment.topLeft,
                    child: Text("Create Virtual Entity",
                        style: TextStyle(fontSize: 25))),
                SizedBox(
                  height: 45,
                ),
                Align(
                    alignment: Alignment.topLeft,
                    child: Row(
                      children: <Widget>[
                        Container(
                          height: MediaQuery.of(context).size.height - 360,
                          child: SingleChildScrollView(
                            child: Column(children: <Widget>[
                              EduGoInput(hintText: "Entity name", width: 450),
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
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                onPressed: () {},
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
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                onPressed: () {},
                                minWidth: 400,
                                height: 60,
                                child: Text("Generate Marker",
                                    style: TextStyle(color: Colors.white)),
                                color: Color.fromARGB(255, 97, 211, 87),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              MaterialButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                onPressed: () {},
                                minWidth: 400,
                                height: 60,
                                child: Text("Create Quiz",
                                    style: TextStyle(color: Colors.white)),
                                color: Color.fromARGB(255, 97, 211, 87),
                              )
                            ],
                          ),
                        ),
                      ],
                    ))
              ],
            ),
          )
        ],
      ),
    );
  }
}
