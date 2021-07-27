import 'dart:convert';

import 'package:mobile/src/Exceptions.dart';
import 'package:mobile/src/Pages/LessonsPage/Models/LessonModels.dart';

import 'package:http/http.dart' as http;
import 'package:mobile/globals.dart';

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