import 'package:edugo_web_app/ui/Views/subject/SubjectsPage.dart';
import 'package:edugo_web_app/ui/widgets/EduGoContainer.dart';
import 'package:edugo_web_app/ui/widgets/EduGoPage.dart';
import 'package:edugo_web_app/ui/widgets/SubjectCard.dart';
import 'package:edugo_web_app/ui/widgets/input_fields/EduGoInput.dart';
import 'package:edugo_web_app/ui/widgets/input_fields/EduGoMultiLineInput.dart';
import 'package:flutter/material.dart';

class LessonPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return EduGoPage(
      child: Stack(
        children: <Widget>[
          EduGoContainer(
            width: MediaQuery.of(context).size.width - 100,
            height: MediaQuery.of(context).size.height - 100,
            child: Column(
              children: [
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Align(
                        alignment: Alignment.topCenter,
                        child: Text("Geometry 101 - Polymorphism",
                            style: TextStyle(fontSize: 25)),
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: Image.asset(
                          "../assets/images/change_title_button.png",
                          width: MediaQuery.of(context).size.width / 3,
                        ),
                      )
                    ]),
                Row(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: SubjectCard(height: 100, width: 1000),
                    )
                  ],
                ),
                Row(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: SubjectCard(height: 200, width: 1000),
                    )
                  ],
                ),
              ],
              /* 
              //Entire screen
              children: <Widget>[
                Align(
                  alignment: Alignment.topLeft,
                  child: Text("Create Subject", style: TextStyle(fontSize: 25)),
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
                                  hintText: "Enter the subject name",
                                  width: 450),
                              SizedBox(height: 25),
                              EduGoInput(
                                  hintText: "Enter the subject grade",
                                  width: 450),
                              SizedBox(height: 25),
                              EduGoMultiLineInput(
                                  hintText: "Enter the subject description",
                                  maxLines: 4,
                                  width: 450),
                              SizedBox(height: 100),
                              MaterialButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => SubjectsPage()),
                                  );
                                },
                                minWidth: 400,
                                height: 60,
                                child: Text("Add Subject",
                                    style: TextStyle(color: Colors.white)),
                                color: Color.fromARGB(255, 97, 211, 87),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: 100),
                      Container(
                        height: MediaQuery.of(context).size.height - 450,
                        //height: 600,
                        width: 500,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(40),
                            topLeft: Radius.circular(40),
                            bottomLeft: Radius.circular(40),
                            bottomRight: Radius.circular(40),
                          ),
                          border: Border.all(
                            color: Colors.black,
                            width: 1,
                            style: BorderStyle.solid,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            SizedBox(height: 60),
                            Icon(
                              Icons.add_a_photo_outlined,
                              size: 200,
                              color: Color.fromARGB(255, 97, 211, 87),
                            ),
                            SizedBox(height: 60),
                            MaterialButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              onPressed: () {},
                              minWidth: 65,
                              height: 40,
                              child: Text("Add Photo",
                                  style: TextStyle(color: Colors.white)),
                              color: Color.fromARGB(255, 97, 211, 87),
                              // margin: EdgeInsets.fromLTRB(20, 100, 20, 20),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            */
            ),
          ),
        ],
      ),
    );
  }
}
