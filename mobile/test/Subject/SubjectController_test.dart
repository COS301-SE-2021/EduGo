import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http/testing.dart' as httpTest;
import 'package:mobile/src/Exceptions.dart';
import 'package:mobile/src/Pages/SubjectsPage/Controller/SubjectController.dart';
import 'package:mobile/src/Pages/SubjectsPage/Models/Subject.dart';
import 'package:test/test.dart';

void main() {
  group('Subject', () {
    test('should fetch subjects if the http call completes successfully',
        () async {
      int id = 1;
      final client = httpTest.MockClient((request) async {
        //if (request.url.path == '/subjects') {
        Map<String, dynamic> body = jsonDecode(request.body);
        if (body["user_id"] == id) {
          return http.Response('''
            {
              "data": [
                {
                  "id": 1,
                  "title": "Test subject 1",
                  "grade": 10
                },
                {
                  "id": 2,
                  "title": "Test subject 2",
                  "grade": 11
                },
                {
                  "id": 3,
                  "title": "Test subject 3",
                  "grade": 12
                }
              ]
            }
          ''', 200);
        }
        return http.Response('', 400);
      });

      List<Subject> subjects = await getSubjectsByUser(client: client);
      expect(subjects.length, 3);
      //expect(subjects[0].id, 1);
      expect(subjects[2].title, 'Test subject 3');
    });

    test('should throw BadResponse error when data is missing', () async {
      int id = 1;
      final client = httpTest.MockClient((request) async {
        //if (request.url.path == '/subjects') {

        return http.Response('''
          {
          }
        ''', 200);
      });

      expect(await () => getSubjectsByUser(client: client), throwsException);
    });

    test('should throw an exception on 400 response', () async {
      //int id = 1;
      final client = httpTest.MockClient((request) async {
        return http.Response('', 400);
      });
      expect(await () => getSubjectsByUser(client: client), throwsException);
    });
  });
}
