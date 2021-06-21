import 'dart:html';
import 'dart:js_util';

import 'package:edugo_web_app/ui/Views/subject/CreateSubjectPage.dart';
import 'package:edugo_web_app/ui/widgets/EduGoNav/NavBar.dart';
import 'package:edugo_web_app/ui/widgets/SubjectCard.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert';
//import 'package:http/http.dart' as http;

class Subject {
  List<Data> data;
  String statusMessage;

  Subject({this.data, this.statusMessage});

  Subject.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
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

    // print('Status code: ${response.statusCode}');
    // print(response.body);

    // for (int i = 0; i < sizeOfSubjectsArray; i++) {
    //   titleArray[i] = subject.data[i].title;
    //   gradeArray[i] = subject.data[i].grade;
    //   descriptionArray[i] = subject.data[i].description;
    // }

    // print(subject.data[0].description);
    // print(subject.data.length);
    sizeOfSubjectsArray = subject.data.length;
    //return subject;
    //print(sizeOfSubjectsArray);

    //displayCards(sizeOfSubjectsArray);
  }

  // if(response.statusCode == 200){

  // }
  // }

  void displayCards() {
    getRequest();

    //print(sizeOfSubjectsArray);

    //ex();
    //print(sizeOfSubjectsArray);
    // for (int i = 0; i < sizeOfSubjectsArray; i++) {
    //   print(titleArray[i]);
    //   print(gradeArray[i]);
    //   print(descriptionArray[i]);
    // }
  }

  @override
  Widget build(BuildContext context) {
    getRequest();
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
