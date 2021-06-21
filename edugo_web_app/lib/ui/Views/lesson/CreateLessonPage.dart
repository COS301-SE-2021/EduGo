import 'dart:html';

import 'package:edugo_web_app/ui/Views/lesson/CreateDate.dart';
import 'package:edugo_web_app/ui/Views/lesson/CreateEndTime.dart';
import 'package:edugo_web_app/ui/Views/lesson/CreateStartTime.dart';
import 'package:edugo_web_app/ui/Views/lesson/LessonPage.dart';
import 'package:edugo_web_app/ui/Views/virtual_entity/VirtualEntityPage.dart';
import 'package:edugo_web_app/ui/Views/virtual_entity/VirtualEntityStorePage.dart';
import 'package:edugo_web_app/ui/widgets/EduGoContainer.dart';
import 'package:edugo_web_app/ui/widgets/EduGoPage.dart';
import 'package:edugo_web_app/ui/widgets/input_fields/EduGoMultiLineInput.dart';
import 'package:flutter/material.dart';

/// API
import 'package:http/http.dart' as http;
import 'dart:convert';

class Lesson {
  //"title": "sdfhfsdh", "date": "bsdsfdhg", "description":"sdfh sfdhd sfhsh" ,"subjectId":"1"
  String title;
  String id;
  String description;
  String subjectId;

  Lesson({
    this.title,
    this.id,
    this.description,
    this.subjectId,
  });

  factory Lesson.fromJson(Map<String, dynamic> json) {
    return Lesson(
      title: json['title'],
      id: json['id'],
      description: json['description'],
      subjectId: json['subjectId'],
    );
  }
}

Future<Lesson> fetchLesson() async {
  final response = await http
      .get(Uri.parse('https://jsonplaceholder.typicode.com/Lessons/1'));

  if (response.statusCode == 200) {
    return Lesson.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load Lesson');
  }
}

////
class CreateLesonPage extends StatefulWidget {
  @override
  _CreateLesonPageState createState() => _CreateLesonPageState();
}

class _CreateLesonPageState extends State<CreateLesonPage> {
  Future<Lesson> futureLesson;
  Lesson _lessonInstance = new Lesson();
  @override
  void initState() {
    super.initState();
    futureLesson = fetchLesson();
    //print(futureLesson);
  }

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
                SizedBox(height: 5),
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
                              SizedBox(
                                  width: 450,
                                  child: TextField(
                                    onChanged: (value) {
                                      setState(() {
                                        _lessonInstance.title = value;
                                      });
                                    },
                                    cursorColor:
                                        Color.fromARGB(255, 97, 211, 87),
                                    decoration: InputDecoration(
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: Color.fromARGB(
                                                  255, 97, 211, 87),
                                              width: 2.0),
                                        ),
                                        border: OutlineInputBorder(),
                                        hintText: "Enter lesson name"),
                                  )),
                              SizedBox(height: 25),
                              SizedBox(
                                width: 450,
                                child: TextField(
                                  cursorColor: Color.fromARGB(255, 97, 211, 87),
                                  decoration: InputDecoration(
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Color.fromARGB(
                                                255, 97, 211, 87),
                                            width: 2.0),
                                      ),
                                      border: OutlineInputBorder(),
                                      hintText: "Enter lesson description"),
                                  keyboardType: TextInputType.multiline,
                                  maxLines: 4,
                                ),
                              ),
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
                              SizedBox(height: 15),
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
                        child: Align(
                            alignment: Alignment.topLeft,
                            child: Column(
                              children: <Widget>[
                                CreateDate(), //state across dart files
                                CreateStartTime(),
                                CreateEndTime(),
                                MaterialButton(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10))),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => LessonPage()),
                                    );
                                  },
                                  minWidth:
                                      MediaQuery.of(context).size.width / 5,
                                  height: 60,
                                  child: Text("Add Lesson",
                                      style: TextStyle(color: Colors.white)),
                                  color: Color.fromARGB(255, 97, 211, 87),
                                ),
                              ],
                            )),
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
