import 'package:edugo_web_app/ui/widgets/EduGoContainer.dart';
import 'package:edugo_web_app/ui/widgets/EduGoPage.dart';
import 'package:flutter/material.dart';
// API
import 'package:http/http.dart' as http;
import 'dart:convert';

//"title": "sdfhfsdh", "date": "bsdsfdhg", "description":"sdfh sfdhd sfhsh" ,"subjectId":"1"
class Lesson {
  String subjectId;

  Lesson({
    this.subjectId,
  });

  Map<String, String> headers = null;
  Future<Lesson> fetchLesson() async {
    final response = await http.post(
        Uri.parse('http://localhost:8080/lesson/getLessonsBySubject'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': '*/*',
        },
        body: jsonEncode(<String,
            String>{})); //Future<Response> post(dynamic url, {Map<String, String> headers, dynamic body, Encoding encoding})

    if (response.statusCode == 200) {
      return Lesson.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load Lesson');
    }
  }

  factory Lesson.fromJson(Map<String, dynamic> json) {
    return Lesson(
      subjectId: json['subjectId'],
    );
  }
}

//
class LessonPage extends StatefulWidget {
  @override
  _LessonPageState createState() => _LessonPageState();
}

class _LessonPageState extends State<LessonPage> {
  Lesson _lessonInstance = new Lesson();
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
                        child: Text(_lessonInstance.subjectId, //title
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
