import 'dart:convert';

import 'package:mobile/src/Exceptions.dart';
import 'package:mobile/src/Pages/LessonsPage/Models/Lesson.dart';
import 'package:mobile/mockApi.dart' as mockApi;

import 'package:http/http.dart' as http;
import 'package:http/testing.dart' as httpMock;
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
  LessonsController({this.mock = false});

  bool mock;

  @override
  LessonsModel init() {
    return LessonsModel(this, lessons: []);
  }

  Future<void> getLessons({required int subject_id}) async {
    return getLessonsBySubject(subject_id, client: mock ? httpMock.MockClient(mockApi.getLessonsBySubjectClient) : http.Client()).then((value) {
      model.update(lessons: value);
    });
  }
}