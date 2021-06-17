import 'package:edugo_web_app/ui/widgets/EduGoContainer.dart';
import 'package:edugo_web_app/ui/widgets/EduGoPage.dart';
import 'package:edugo_web_app/ui/widgets/input_fields/EduGoInput.dart';
import 'package:edugo_web_app/ui/widgets/input_fields/EduGoMultiLineInput.dart';
import 'package:flutter/material.dart';

class CreateSubjectPage extends StatelessWidget {
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
                  child: Text("Create Subject", style: TextStyle(fontSize: 25)),
                ),
                SizedBox(height: 35),
                Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                    height: MediaQuery.of(context).size.height - 360,
                    child: SingleChildScrollView(
                      child: Row(
                        children: [
                          Column(
                            children: <Widget>[
                              SizedBox(height: 40),
                              EduGoInput(
                                  hintText: "Enter the subject name",
                                  width: 450),
                              SizedBox(height: 60),
                              EduGoInput(
                                  hintText: "Enter the subject grade",
                                  width: 450),
                              SizedBox(height: 65),
                              EduGoMultiLineInput(
                                  hintText: "Enter the subject description",
                                  maxLines: 3,
                                  width: 450)
                            ],
                          ),
                          Container(
                              //  width: MediaQuery.of(context).size.width - 200,
                              //  height: MediaQuery.of(context).size.height - 200,

                              ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
