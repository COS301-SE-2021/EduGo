import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http/testing.dart' as httpTest;
import 'package:mobile/src/Exceptions.dart';
import 'package:mobile/src/Pages/LessonsPage/Controller/LessonController.dart';
import 'package:mobile/src/Pages/LessonsPage/Models/Lesson.dart';
import 'package:test/test.dart';

void main() {
  group('Lesson', () {
    test('should fetch lessons if the http call completes successfully', () async {
      int id = 1;
      final client = httpTest.MockClient((request) async {
        Map<String, dynamic> body = jsonDecode(request.body);
        //TODO: Try using assertions instead
        if (body["subjectId"] == id) {
          return new http.Response('''
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
        }
        return http.Response('', 400);
      });

      List<Lesson> lessons = await getLessonsBySubject(id, client: client);
      expect(lessons.length, 3);
      expect(lessons[0].id, 1);
      expect(lessons[2].startTime, '12:00');
    });

    test('should throw BadResponse error when data is missing', () async {
      final client = httpTest.MockClient((request) async {
        return http.Response('{}', 200);
      });

      expect(await () => getLessonsBySubject(1, client: client), throwsA(isA<BadResponse>()));
    });

    test('should throw an exception on 400 response', () async {
      final client = httpTest.MockClient((request) async {
        return http.Response('', 400);
      });

      expect(await () => getLessonsBySubject(1, client: client), throwsException);
    });
  });
}