import 'dart:convert';

import 'package:mobile/src/Exceptions.dart';
import 'package:mobile/src/Pages/LessonsPage/Models/Lesson.dart';

import 'package:http/http.dart' as http;
import 'package:http/testing.dart' as mock;
import 'package:mobile/globals.dart';
import 'package:mobile/src/Pages/LessonsPage/Models/LessonsModel.dart';
import 'package:momentum/momentum.dart';

Future<List<Lesson>> getLessonsBySubject(int subject_id, {required http.Client client}) async {
  final response = await client.post(
    Uri.parse("${baseUrl}lesson/getLessonsBySubject"),
    headers: <String, String>{'Content-Type': 'application/json'},
    body: jsonEncode(<String, int>{'subjectId': subject_id})
  );

  if (response.statusCode == 200) {
    Map<String, dynamic> json = jsonDecode(response.body);
    if (json['data'] != null) {
      List<Lesson> lessons = (json['data'] as List).map((e) => Lesson.fromJson(e)).toList();
      return lessons;
    }
    else throw new BadResponse('No data property');
  }
  throw Exception('Not a code 200');
}

class LessonsController extends MomentumController<LessonsModel> {
  final client = mock.MockClient((request) async {
    return http.Response('''
      {
        "data": [
          {
            "id": 1,
            "title": "Lesson 1",
            "description": "This is lesson 1",
            "startTime": "10:00",
            "endTime": "11:00"
          },
          {
            "id": 2,
            "title": "Lesson 2",
            "description": "This is lesson 2",
            "startTime": "11:00",
            "endTime": "12:00"
          },
          {
            "id": 3,
            "title": "Lesson 3",
            "description": "This is lesson 3",
            "startTime": "12:00",
            "endTime": "13:00"
          }
        ]
      }
    ''', 200);
  });

  @override
  LessonsModel init() {
    return LessonsModel(this, lessons: []);
  }

  @override
  void bootstrap() {
    this.getLessonsBySubject(1, client: client);
  }

  Future<void> getLessonsBySubject(int subject_id, {required http.Client client}) async {
    final response = await client.post(
      Uri.parse("${baseUrl}lesson/getLessonsBySubject"),
      headers: <String, String>{'Content-Type': 'application/json'},
      body: jsonEncode(<String, int>{'subjectId': subject_id})
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> json = jsonDecode(response.body);
      if (json['data'] != null) {
        List<Lesson> lessons = (json['data'] as List).map((e) => Lesson.fromJson(e)).toList();
        model.update(lessons: lessons);
      }
      else throw new BadResponse('No data property');
    }
    throw Exception('Not a code 200');
  }

}