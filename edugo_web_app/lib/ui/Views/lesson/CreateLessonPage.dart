import 'package:edugo_web_app/ui/Views/lesson/LessonsPage.dart';
import 'package:edugo_web_app/ui/Views/virtual_entity/VirtualEntityPage.dart';
import 'package:edugo_web_app/ui/Views/virtual_entity/VirtualEntityStorePage.dart';
import 'package:edugo_web_app/ui/widgets/EduGoContainer.dart';
import 'package:edugo_web_app/ui/widgets/EduGoPage.dart';
import 'package:edugo_web_app/ui/widgets/input_fields/EduGoInput.dart';
import 'package:edugo_web_app/ui/widgets/input_fields/EduGoMultiLineInput.dart';
import 'package:flutter/material.dart';

class CreateLesonPage extends StatelessWidget {
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
                  child: Text("Create Lesson", style: TextStyle(fontSize: 25)),
                ),
                SizedBox(height: 35),
                Align(
                  alignment: Alignment.topLeft,
                  child: Row(
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height - 360,
                        child: SingleChildScrollView(
                          child: Column(
                            children: <Widget>[
                              SizedBox(height: 25),
                              EduGoInput(
                                  hintText: "Enter the lesson name",
                                  width: 450),
                              SizedBox(height: 25),
                              EduGoMultiLineInput(
                                  hintText: "Enter the lesson description",
                                  maxLines: 4,
                                  width: 450),
                              SizedBox(height: 25),
                              // Create entity
                              MaterialButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            VirtualEntityPage()),
                                  );
                                },
                                minWidth: 400,
                                height: 60,
                                child: Text("Create Virtual Entity",
                                    style: TextStyle(color: Colors.white)),
                                color: Color.fromARGB(255, 97, 211, 87),
                              ),
                              //
                              SizedBox(height: 25),
                              // Upload entity
                              MaterialButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            VirtualEntityStore()),
                                  );
                                },
                                minWidth: 400,
                                height: 60,
                                child: Text("Upload Virtual Entity",
                                    style: TextStyle(color: Colors.white)),
                                color: Color.fromARGB(255, 97, 211, 87),
                              ),
                              //
                              SizedBox(height: 25),
                              /*MaterialButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => LessonsPage()),
                                  );
                                },
                                minWidth: 400,
                                height: 60,
                                child: Text("Add Lesson",
                                    style: TextStyle(color: Colors.white)),
                                color: Color.fromARGB(255, 97, 211, 87),
                              ),*/
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: 100),
                      Container(
                        height: MediaQuery.of(context).size.height - 350,
                        width: 500,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(40),
                            topLeft: Radius.circular(40),
                            bottomLeft: Radius.circular(40),
                            bottomRight: Radius.circular(40),
                          ),
                          border: Border.all(
                            color: Colors.grey,
                            width: 1,
                            style: BorderStyle.solid,
                          ),
                        ),
                        child: Column(
                          children: [
                            Row(children: [CreateDate()]),
                            Row(children: [CreateTime()])
                          ],
                        ),
                      ),
                    ],
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
