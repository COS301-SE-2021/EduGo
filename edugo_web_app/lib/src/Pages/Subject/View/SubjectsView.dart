import 'package:edugo_web_app/src/Pages/EduGo.dart';

class SubjectsView extends StatefulWidget {
  const SubjectsView({Key key}) : super(key: key);

  @override
  State<SubjectsView> createState() => _SubjectsViewState();
}

class _SubjectsViewState extends State<SubjectsView> {
  bool plublished = true;
  @override
  Widget build(BuildContext context) {
    return MomentumBuilder(
        controllers: [],
        builder: (context, snapshot) {
          return PageLayout(
            top: 0,
            left: 0,
            right: 0,
            child: Stack(
              children: [
                Container(
                  padding: EdgeInsets.only(top: 0),
                  child: ListView(
                    padding: EdgeInsets.only(
                      top: 0,
                    ),
                    children: <Widget>[
                      StickyHeader(
                        header: Material(
                          elevation: 40,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            padding: EdgeInsets.only(
                                right: 50, left: 100, top: 25, bottom: 25),
                            child: Column(
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      "Created Subjects",
                                      style: TextStyle(
                                        fontSize: 32,
                                      ),
                                    ),
                                    Spacer(),
                                    MouseRegion(
                                      cursor: SystemMouseCursors.click,
                                      child: GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            plublished = !plublished;
                                          });
                                        },
                                        child: Container(
                                          padding: EdgeInsets.only(
                                            bottom:
                                                5, // Space between underline and text
                                          ),
                                          decoration: plublished
                                              ? BoxDecoration(
                                                  border: Border(
                                                    bottom: BorderSide(
                                                      color: Color.fromARGB(
                                                          255, 97, 211, 87),
                                                      width:
                                                          4.0, // Underline thickness
                                                    ),
                                                  ),
                                                )
                                              : BoxDecoration(),
                                          child: Text(
                                            "Published",
                                            style: TextStyle(
                                              fontSize: 22,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 40,
                                    ),
                                    MouseRegion(
                                      cursor: SystemMouseCursors.click,
                                      child: GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            plublished = !plublished;
                                          });
                                        },
                                        child: Container(
                                          padding: EdgeInsets.only(
                                            bottom:
                                                5, // Space between underline and text
                                          ),
                                          decoration: !plublished
                                              ? BoxDecoration(
                                                  border: Border(
                                                    bottom: BorderSide(
                                                      color: Color.fromARGB(
                                                          255, 97, 211, 87),
                                                      width:
                                                          4.0, // Underline thickness
                                                    ),
                                                  ),
                                                )
                                              : BoxDecoration(),
                                          child: Text(
                                            "Unpublished",
                                            style: TextStyle(
                                              fontSize: 22,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Spacer(),
                                    SubjectButton(
                                      onPressed: () {
                                        MomentumRouter.goto(
                                            context, CreateSubjectView);
                                      },
                                      child: Row(
                                        children: <Widget>[
                                          Icon(
                                            Icons.add,
                                            color: Colors.white,
                                          ),
                                          SizedBox(width: 20),
                                          Text(
                                            "Create Subject",
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                      width: 250,
                                      height: 60,
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                        content: plublished
                            ? GridView.count(
                                physics: NeverScrollableScrollPhysics(),
                                primary: false,
                                shrinkWrap: true,
                                padding: const EdgeInsets.only(
                                    right: 30, left: 30, top: 40, bottom: 80),
                                crossAxisSpacing: 40,
                                mainAxisSpacing: 40,
                                crossAxisCount: 4,
                                childAspectRatio: 1 / 1.1,
                                children: [
                                  SubjectCard(
                                    title: "Mathematics",
                                    grade: "12",
                                  ),
                                  SubjectCard(
                                    title: "Mathematics",
                                    grade: "12",
                                  ),
                                  SubjectCard(
                                    title: "Mathematics",
                                    grade: "12",
                                  ),
                                  SubjectCard(
                                    title: "Mathematics",
                                    grade: "12",
                                  ),
                                  SubjectCard(
                                    title: "Mathematics",
                                    grade: "12",
                                  ),
                                  SubjectCard(
                                    title: "Mathematics",
                                    grade: "12",
                                  ),
                                  SubjectCard(
                                    title: "Mathematics",
                                    grade: "12",
                                  ),
                                  SubjectCard(
                                    title: "Mathematics",
                                    grade: "12",
                                  ),
                                  SubjectCard(
                                    title: "Mathematics",
                                    grade: "12",
                                  ),
                                  SubjectCard(
                                    title: "Mathematics",
                                    grade: "12",
                                  ),
                                  SubjectCard(
                                    title: "Mathematics",
                                    grade: "12",
                                  ),
                                  SubjectCard(
                                    title: "Mathematics",
                                    grade: "12",
                                  ),
                                  SubjectCard(
                                    title: "Mathematics",
                                    grade: "12",
                                  ),
                                  SubjectCard(
                                    title: "Mathematics",
                                    grade: "12",
                                  ),
                                ],
                              )
                            : GridView.count(
                                physics: NeverScrollableScrollPhysics(),
                                primary: false,
                                shrinkWrap: true,
                                padding: const EdgeInsets.only(
                                    right: 30, left: 30, top: 40, bottom: 80),
                                crossAxisSpacing: 40,
                                mainAxisSpacing: 40,
                                crossAxisCount: 4,
                                childAspectRatio: 1 / 1.1,
                                children: [
                                  SubjectCard(
                                    title: "English",
                                    grade: "11",
                                  ),
                                  SubjectCard(
                                    title: "English",
                                    grade: "11",
                                  ),
                                  SubjectCard(
                                    title: "English",
                                    grade: "11",
                                  ),
                                  SubjectCard(
                                    title: "English",
                                    grade: "11",
                                  ),
                                  SubjectCard(
                                    title: "English",
                                    grade: "11",
                                  ),
                                  SubjectCard(
                                    title: "English",
                                    grade: "11",
                                  ),
                                  SubjectCard(
                                    title: "English",
                                    grade: "11",
                                  ),
                                  SubjectCard(
                                    title: "English",
                                    grade: "11",
                                  ),
                                  SubjectCard(
                                    title: "English",
                                    grade: "11",
                                  ),
                                  SubjectCard(
                                    title: "English",
                                    grade: "11",
                                  ),
                                  SubjectCard(
                                    title: "English",
                                    grade: "11",
                                  ),
                                  SubjectCard(
                                    title: "English",
                                    grade: "11",
                                  ),
                                  SubjectCard(
                                    title: "English",
                                    grade: "11",
                                  ),
                                  SubjectCard(
                                    title: "English",
                                    grade: "11",
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
        });
  }
}


// import 'dart:html';
// import 'dart:js_util';
// import 'package:edugo_web_app/ui/Views/subject/CreateSubjectPage.dart';
// import 'package:edugo_web_app/ui/widgets/EduGoNav/NavBar.dart';
// import 'package:edugo_web_app/ui/widgets/SubjectCard.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// class Subjects {
//   List<Subject> data;
//   String statusMessage;

//   Subjects({this.data, this.statusMessage});

//   Subjects.fromJson(Map<String, dynamic> json) {
//     if (json['data'] != null) {
//       data = <Subject>[];
//       json['data'].forEach((v) {
//         data.add(new Subject.fromJson(v));
//       });
//     }
//     statusMessage = json['statusMessage'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     if (this.data != null) {
//       data['data'] = this.data.map((v) => v.toJson()).toList();
//     }
//     data['statusMessage'] = this.statusMessage;
//     return data;
//   }
// }

// class Subject {
//   int id;
//   String title;
//   int grade;
//   String description;
//   int educatorId;

//   Subject({this.id, this.title, this.grade, this.description, this.educatorId});

//   Subject.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     title = json['title'];
//     grade = json['grade'];
//     description = json['description'];
//     educatorId = json['educatorId'];
//   }

//   int getSubjectID() {
//     return this.id;
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> subject = new Map<String, dynamic>();
//     subject['id'] = this.id;
//     subject['title'] = this.title;
//     subject['grade'] = this.grade;
//     subject['description'] = this.description;
//     subject['educatorId'] = this.educatorId;
//     return subject;
//   }
// }

// class SubjectsPage extends StatefulWidget {
//   @override
//   _SubjectsPageState createState() => _SubjectsPageState();
// }

// class _SubjectsPageState extends State<SubjectsPage> {
//   String subjects;
//   Subjects subjectsmodel;
//   static const urlPrefix =
//       'http://localhost:8080/subject/getSubjectsbyEducator';

//   Future<http.Response> getRequest() async {
//     final url = Uri.parse('$urlPrefix');
//     return http.post(url,
//         headers: {'contentType': 'application/json'},
//         body: {'educatorId': '3'});
//   }

//   List<Widget> getEntities(List<Subject> subjectList) {
//     if (subjectList != null && subjectList.isNotEmpty) {
//       return subjectList
//           .map((subject) => new Container(
//                 child: SubjectCard(
//                     title: subject.title,
//                     grade: subject.grade.toString(),
//                     id: subject.id),
//               ))
//           .toList();
//     } else {
//       List<Widget> subjects = <Widget>[];
//       subjects.add(
//         new Container(
//           child: SubjectCard(
//             title: "There are no subjects to display",
//             //grade: '',
//           ),
//         ),
//       );
//       return subjects;
//       // List<Subject> newList = <Subject>[];
//       // return newList
//       //     .map((subject) => new Container(
//       //           child: SubjectCard(
//       //             title: 'There are no subjects.',
//       //             //grade: subject.grade.toString(),
//       //           ),
//       //         ))
//       //     .toList();
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     getRequest().then((value) {
//       setState(() {
//         subjects = value.body;
//         subjectsmodel = Subjects.fromJson(jsonDecode(subjects));
//       });
//     });
//     return Scaffold(
//       body: Stack(
//         children: <Widget>[
//           NavBar(),
//           Container(
//             padding: EdgeInsets.only(top: 40, bottom: 40, left: 100, right: 80),
//             margin: EdgeInsets.only(left: 100, top: 100),
//             width: MediaQuery.of(context).size.width - 100,
//             height: MediaQuery.of(context).size.height - 100,
//             decoration: BoxDecoration(
//               border: Border.all(
//                 style: BorderStyle.solid,
//               ),
//             ),
//             child: SingleChildScrollView(
//               child: Column(
//                 children: <Widget>[
//                   Row(
//                     children: [
//                       Expanded(
//                         child: Align(
//                           alignment: Alignment.topLeft,
//                           child: Text(
//                             "Subjects",
//                             style: TextStyle(
//                               fontSize: 25,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         ),
//                       ),
//                       Align(
//                         alignment: Alignment.topRight,
//                         child: MaterialButton(
//                           shape: RoundedRectangleBorder(
//                               borderRadius:
//                                   BorderRadius.all(Radius.circular(5))),
//                           onPressed: () {
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                   builder: (context) => CreateSubjectPage()),
//                             );
//                           },
//                           minWidth: 50,
//                           height: 60,
//                           color: Color.fromARGB(255, 97, 211, 87),
//                           child: Row(
//                             children: <Widget>[
//                               Icon(
//                                 Icons.add_outlined,
//                                 color: Colors.white,
//                               ),
//                               Text(
//                                 "Add Subject",
//                                 style: TextStyle(color: Colors.white),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                   Text(
//                     "Published Subjects",
//                     style: TextStyle(
//                       fontSize: 25,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   Container(
//                     height: MediaQuery.of(context).size.height - 200,
//                     padding: EdgeInsets.only(top: 75),
//                     child: GridView.count(
//                       childAspectRatio:
//                           MediaQuery.of(context).size.height / 1000,
//                       primary: false,
//                       padding: const EdgeInsets.all(20),
//                       crossAxisSpacing: 30,
//                       shrinkWrap: true,
//                       scrollDirection: Axis.vertical,
//                       mainAxisSpacing: 20,
//                       crossAxisCount: 4,
//                       children: getEntities(subjectsmodel.data),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }