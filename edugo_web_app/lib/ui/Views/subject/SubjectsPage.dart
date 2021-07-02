import 'dart:html';
import 'dart:js_util';
import 'package:edugo_web_app/ui/Views/subject/CreateSubjectPage.dart';
import 'package:edugo_web_app/ui/widgets/EduGoNav/NavBar.dart';
import 'package:edugo_web_app/ui/widgets/SubjectCard.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Subjects {
  List<Subject> data;
  String statusMessage;

  Subjects({this.data, this.statusMessage});

  Subjects.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Subject>[];
      json['data'].forEach((v) {
        data.add(new Subject.fromJson(v));
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

class Subject {
  int id;
  String title;
  int grade;
  String description;
  int educatorId;

  Subject({this.id, this.title, this.grade, this.description, this.educatorId});

  Subject.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    grade = json['grade'];
    description = json['description'];
    educatorId = json['educatorId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> subject = new Map<String, dynamic>();
    subject['id'] = this.id;
    subject['title'] = this.title;
    subject['grade'] = this.grade;
    subject['description'] = this.description;
    subject['educatorId'] = this.educatorId;
    return subject;
  }
}

class SubjectsPage extends StatefulWidget {
  @override
  _SubjectsPageState createState() => _SubjectsPageState();
}

class _SubjectsPageState extends State<SubjectsPage> {
  String subjects;
  Subjects subjectsmodel;
  static const urlPrefix =
      'http://localhost:8080/subject/getSubjectsbyEducator';

  Future<http.Response> getRequest() async {
    final url = Uri.parse('$urlPrefix');
    // var response = await
    return http.post(url,
        headers: {'contentType': 'application/json'},
        body: {'educatorId': '1'});
  }

  Widget getTextWidgets(List<Subject> strings) {
    for (int counter = 0; counter < strings.length; counter++) {
      if (counter % 2 == 0) {
        return new Row(
            children: strings
                .map((item) => new Container(
                      child: SubjectCard(
                        title: item.title,
                        grade: item.grade.toString(),
                        description: item.description,
                      ),
                    ))
                .toList());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    //displayCards();
    // print(titleArray.first);

    // if (titleArray.isEmpty) print("NOT EMPOTY");
    getRequest().then((value) {
      setState(() {
        subjects = value.body;
        subjectsmodel = Subjects.fromJson(jsonDecode(subjects));
      });
    });
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
                  Text(
                    "Published Subjects",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height - 100,
                    child: ListView(
                      padding: EdgeInsets.symmetric(vertical: 60),
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      children: <Widget>[getTextWidgets(subjectsmodel.data)],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
