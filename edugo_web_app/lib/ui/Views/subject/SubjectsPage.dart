import 'package:edugo_web_app/ui/Views/subject/CreateSubjectPage.dart';
import 'package:edugo_web_app/ui/widgets/EduGoNav/NavBar.dart';
import 'package:edugo_web_app/ui/widgets/SubjectCard.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert';

class SubjectsPage extends StatefulWidget {
  @override
  _SubjectsPageState createState() => _SubjectsPageState();
}

class _SubjectsPageState extends State<SubjectsPage> {
  static const urlPrefix = 'http://localhost:8080/subject/createSubject';

  String subjectTitle;
  String subjectGrade;
  String subjectDescription;

  void getRequest() async {
    final url = Uri.parse('$urlPrefix/posts');
    Response response = await get(url);
    print('Status code: ${response.statusCode}');
    print('Headers: ${response.headers}');
    print('Body: ${response.body}');

    // if(response.statusCode == 200){

    // }
  }

  void displayCards() async {
    getRequest();
  }

  @override
  Widget build(BuildContext context) {
    displayCards();
    return Scaffold(
      body: Stack(
        children: <Widget>[
          NavBar(),
          Container(
            padding: EdgeInsets.only(top: 40, bottom: 40, left: 100, right: 80),
            margin: EdgeInsets.only(left: 100, top: 100),
            width: MediaQuery.of(context).size.width - 100,
            height: MediaQuery.of(context).size.height - 100,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.red,
                //width: 1,
                style: BorderStyle.solid,
              ),
            ),
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Row(
                    children: [
                      Expanded(
                        child: Align(
                          alignment: Alignment.topLeft,
                          //child: SizedBox(
                          child: Text(
                            "Subjects",
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: MaterialButton(
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5))),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CreateSubjectPage()),
                            );
                          },
                          minWidth: 50,
                          height: 60,
                          color: Color.fromARGB(255, 97, 211, 87),
                          // child: Text("Add Subject.",
                          //     style: TextStyle(color: Colors.white)),
                          child: Row(
                            children: <Widget>[
                              Icon(
                                Icons.add_outlined,
                                color: Colors.white,
                              ),
                              Text(
                                "Add Subject",
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  // Row(
                  //   children: <Widget>[
                  // Align(
                  //   alignment: Alignment.bottomRight,
                  //child:
                  Text(
                    "Published Subjects",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                    // style: TextStyle(color: Colors.black),
                  ),
                  //   ),
                  // ],
                  // ),
                  // Align(
                  //alignment: Alignment.topLeft,
                  //child:
                  SubjectCard(
                      title: "Bio", grade: "Grade 10", description: "Test1"),

                  //SubjectCard(),
                  //)
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
