import 'package:edugo_web_app/ui/Views/subject/CreateSubjectPage.dart';
import 'package:edugo_web_app/ui/widgets/EduGoNav/NavBar.dart';
import 'package:edugo_web_app/ui/widgets/SubjectCard.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert';

class Subject {
  List<Data> data;
  String statusMessage;

  Subject({this.data, this.statusMessage});

  Subject.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      // ignore: deprecated_member_use
      data = new List<Data>();
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
    statusMessage = json['statusMessage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    data['statusMessage'] = this.statusMessage;
    return data;
  }
}

class Data {
  int id;
  String title;
  int grade;
  String description;
  int educatorId;

  Data({this.id, this.title, this.grade, this.description, this.educatorId});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    grade = json['grade'];
    description = json['description'];
    educatorId = json['educatorId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['grade'] = this.grade;
    data['description'] = this.description;
    data['educatorId'] = this.educatorId;
    return data;
  }
}

Subject subject;
int sizeOfSubjectsArray;
List titleArray = [];
List gradeArray = [];
List descriptionArray = [];

class SubjectsPage extends StatefulWidget {
  @override
  _SubjectsPageState createState() => _SubjectsPageState();
}

class _SubjectsPageState extends State<SubjectsPage> {
  static const urlPrefix =
      'http://localhost:8080/subject/getSubjectsbyEducator';

  void getRequest() async {
    final url = Uri.parse('$urlPrefix');
    var response = await post(url,
        headers: {'contentType': 'application/json'},
        body: {'educatorId': '1'});

    subject = Subject.fromJson(jsonDecode(response.body));
    sizeOfSubjectsArray = subject.data.length;

    for (int i = 0; i < sizeOfSubjectsArray; i++) {
      titleArray.add(subject.data[i].title);
      gradeArray.add(subject.data[i].grade.toString());
      descriptionArray.add(subject.data[i].description);
    }
  }

  void displayCards() async {
    await getRequest();

    // print(sizeOfSubjectsArray);
    // print(titleArray);

    // print(gradeArray[0].runtimeType);

    if (sizeOfSubjectsArray > 0) {
      for (int size = 0; size < 1; size++) {
        SubjectCard(
            title: titleArray[0],
            grade: gradeArray[0],
            description: descriptionArray[0]);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    //displayCards();
    // print(titleArray.first);

    // if (titleArray.isEmpty) print("NOT EMPOTY");

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
                //color: Colors.red,
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
                  // SubjectCard(
                  //     title: "Bio", grade: "Grade 10", description: "Test1"),
                  SubjectCard(
                      title: "Math", grade: "Gtrade 10", description: "ok"),

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
