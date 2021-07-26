import 'dart:convert';

import 'package:mobile/src/Pages/LessonsPage/Models/LessonModels.dart';

import 'package:http/http.dart' as http;
import 'package:mobile/globals.dart';

Future<Lesson> getLesson(int subject_id, {required http.Client client}) async {
  final response = await client.post(
    Uri.parse("${baseUrl}lesson/getLessonsBySubject"),
    headers: <String, String>{'Content-Type': 'application/json'},
    body: jsonEncode(<String, int>{'subjectId': subject_id})
  );

  if (response.statusCode == 200) {
    return Lesson.fromJson(jsonDecode(response.body));
  }
  throw Exception('Not a code 200');
}