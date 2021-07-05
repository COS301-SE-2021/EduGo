// import 'package:edugo_web_app/ui/Views/lesson/CreateLessonPage.dart';
// import 'package:edugo_web_app/ui/widgets/EduGoNav/NavBar.dart';
// import 'package:edugo_web_app/ui/widgets/LessonCard.dart';
// import 'package:flutter/material.dart';

// class LessonsPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: Stack(
//       children: <Widget>[
//         NavBar(),
//         Container(
//           padding: EdgeInsets.only(top: 40, bottom: 40, left: 100, right: 80),
//           margin: EdgeInsets.only(left: 100, top: 100),
//           width: MediaQuery.of(context).size.width - 100,
//           height: MediaQuery.of(context).size.height - 100,
//           decoration: BoxDecoration(
//             border: Border.all(
//               color: Colors.red,
//               style: BorderStyle.solid,
//             ),
//           ),
//           child: SingleChildScrollView(
//             child: Column(
//               children: <Widget>[
//                 Row(
//                   children: [
//                     Expanded(
//                       child: Align(
//                         alignment: Alignment.topLeft,
//                         child: Text(
//                           "Lessons",
//                           style: TextStyle(
//                             fontSize: 25,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ),
//                     ),
//                     Align(
//                       alignment: Alignment.topRight,
//                       child: MaterialButton(
//                         shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.all(Radius.circular(5))),
//                         onPressed: () {
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                                 builder: (context) => CreateLesonPage()),
//                           );
//                         },
//                         minWidth: 50,
//                         height: 60,
//                         child: Text("Add Lesson.",
//                             style: TextStyle(color: Colors.white)),
//                         color: Color.fromARGB(255, 97, 211, 87),
//                       ),
//                     ),
//                   ],
//                 ),
//                 Align(
//                   alignment: Alignment.centerLeft,
//                   child: LessonCard(),
//                 )
//               ],
//             ),
//           ),
//         ),
//       ],
//     ));
//   }
// }

import 'dart:html';
import 'dart:js_util';
import 'package:edugo_web_app/ui/Views/Lesson/CreateLessonPage.dart';
import 'package:edugo_web_app/ui/Views/subject/SubjectsPage.dart';
import 'package:edugo_web_app/ui/widgets/EduGoNav/NavBar.dart';
import 'package:edugo_web_app/ui/widgets/LessonCard.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Lessons {
  List<Lesson> data;
  String statusMessage;

  Lessons({this.data, this.statusMessage});

  Lessons.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Lesson>[];
      json['data'].forEach((v) {
        data.add(new Lesson.fromJson(v));
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

class Lesson {
  int id;
  String title;
  //int grade;
  String description;
  String date;

  Lesson({this.id, this.title, this.description, this.date});

  Lesson.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    //grade = json['grade'];
    description = json['description'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> lesson = new Map<String, dynamic>();
    lesson['id'] = this.id;
    lesson['title'] = this.title;
    //Lesson['grade'] = this.grade;
    lesson['description'] = this.description;
    lesson['date'] = this.date;
    return lesson;
  }
}

class LessonsPage extends StatefulWidget {
  @override
  _LessonsPageState createState() => _LessonsPageState();
}

class _LessonsPageState extends State<LessonsPage> {
  String lessons;
  Lessons lessonsmodel;
  static const urlPrefix = 'http://localhost:8080/lesson/getLessonsBySubject';

  Future<http.Response> getRequest() async {
    final url = Uri.parse('$urlPrefix');
    return http.post(url,
        headers: {'contentType': 'application/json'},
        body: {'subjectId': '23'});
  }

  List<Widget> getEntities(List<Lesson> lessonList) {
    if (lessonList != null && lessonList.isNotEmpty) {
      return lessonList
          .map((lesson) => new Container(
                child: LessonCard(
                  title: lesson.title,
                  //grade: Lesson.grade.toString(),
                  description: lesson.description,
                  date: lesson.date,
                ),
              ))
          .toList();
    } else {
      List<Widget> lessons = <Widget>[];
      lessons.add(
        new Container(
          child: LessonCard(
            title: "There are no Lessons to display",
            //grade: '',
          ),
        ),
      );
      return lessons;
      // List<Lesson> newList = <Lesson>[];
      // return newList
      //     .map((Lesson) => new Container(
      //           child: LessonCard(
      //             title: 'There are no Lessons.',
      //             //grade: Lesson.grade.toString(),
      //           ),
      //         ))
      //     .toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    getRequest().then((value) {
      setState(() {
        lessons = value.body;
        lessonsmodel = Lessons.fromJson(jsonDecode(lessons));
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
                            "Lessons",
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
                                  builder: (context) => SubjectsPage()),
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
                                "Add Lesson",
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "Published Lessons",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height - 200,
                    padding: EdgeInsets.only(top: 75),
                    child: GridView.count(
                      childAspectRatio:
                          MediaQuery.of(context).size.height / 1000,
                      primary: false,
                      padding: const EdgeInsets.all(20),
                      crossAxisSpacing: 30,
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      mainAxisSpacing: 20,
                      crossAxisCount: 4,
                      children: getEntities(lessonsmodel.data),
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
