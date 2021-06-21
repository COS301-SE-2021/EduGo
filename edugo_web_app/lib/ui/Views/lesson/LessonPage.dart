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
            width: MediaQuery.of(context).size.width - 50,
            height: MediaQuery.of(context).size.height - 50,
            child: Column(
              children: [
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text("Geometry 101 - Polymorphism",
                            style: TextStyle(fontSize: 25)),
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: Image.asset(
                            "../assets/images/change_title_button.png",
                            width: MediaQuery.of(context).size.width / 3,
                            height: 50),
                      )
                    ]),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text("Description: ",
                            style: TextStyle(fontSize: 15)),
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: Image.asset(
                            "../assets/images/edit_description_button.png",
                            width: MediaQuery.of(context).size.width / 3,
                            height: 50),
                      )
                    ]),
                Row(children: [
                  SizedBox(
                    width: 1000.0,
                    height: 100.0,
                    child: Card(child: Text('Long Description')),
                  )
                ]),
                Row(
                  children: [
                    Container(
                        padding: EdgeInsets.all(10),
                        child: RichText(
                            text: TextSpan(
                          text: 'Virtual Entity',
                        ))),
                  ],
                ),
                Row(children: [
                  SizedBox(
                      width: 1000.0,
                      height: 300.0,
                      child: Column(
                        children: [Row(), Row()],
                      )),
                ]),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
/*
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
                    
 */
