import 'package:edugo_web_app/ui/Views/lesson/CreateDate.dart';
import 'package:edugo_web_app/ui/Views/lesson/CreateEndTime.dart';
import 'package:edugo_web_app/ui/Views/lesson/CreateStartTime.dart';
import 'package:edugo_web_app/ui/Views/subject/SubjectsPage.dart';
import 'package:edugo_web_app/ui/Views/virtual_entity/CreateVirtualEntityPage.dart';
import 'package:edugo_web_app/ui/Views/virtual_entity/VirtualEntityStorePage.dart';
import 'package:edugo_web_app/ui/widgets/EduGoContainer.dart';
import 'package:edugo_web_app/ui/widgets/EduGoPage.dart';
import 'package:flutter/material.dart';

/// API
import 'package:http/http.dart' as http;
import 'dart:convert';

class Lesson {
  //"title": "sdfhfsdh", "date": "bsdsfdhg", "description":"sdfh sfdhd sfhsh" ,"subjectId":"1"
  String title = "";
  String date = DateTime.now().toString();
  String description = "";
  String subjectId = "1";

  Lesson({
    this.title,
    this.date,
    this.description,
    this.subjectId,
  });

  factory Lesson.fromJson(Map<String, dynamic> json) {
    return Lesson(
      title: json['title'],
      date: json['date'],
      description: json['description'],
      subjectId: json['subjectId'],
    );
  }
}

Future<http.Response> createLesson() {
  return http.post(
    Uri.parse('http://localhost:8080/lesson/createLesson'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      "title": "", //title,
      "date": "", //date,
      "description": "", //description,
      "subjectId": "1"
    }),
  );
}
/*Future<Lesson> createLesson() async {
  final response =
      await http.get(Uri.parse('http://localhost:8080/lesson/createLesson'));

  if (response.statusCode == 200) {
    return Lesson.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load Lesson');
  }
}*/

////
class CreateLesonPage extends StatefulWidget {
  @override
  _CreateLesonPageState createState() => _CreateLesonPageState();
}

class _CreateLesonPageState extends State<CreateLesonPage> {
// Future<Lesson> futureLesson;
  Future<http.Response> futureLesson;
  Lesson _lessonInstance = new Lesson();
  @override
  void initState() {
    super.initState();
    // futureLesson = createLesson();
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
                                            CreateVirtualEntityPage()),
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
                        width: 400,
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
                                    createLesson()
                                        .then((value) => print(value.body));
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => SubjectsPage()),
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
