import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http/testing.dart' as httpTest;
import 'package:mobile/src/Exceptions.dart';
import 'package:mobile/src/Pages/SubjectsPage/Controller/SubjectController.dart';
import 'package:mobile/src/Pages/SubjectsPage/Models/Subject.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test/test.dart';

void main() {
  group('Subject', () {
    test('should fetch subjects if the http call completes successfully',
        () async {
      int id = 1;
      final client = httpTest.MockClient((request) async {
        //if (request.url.path == '/subjects') {
        return http.Response('''
            {
              "data": [
                {
                  "id": 1,
                  "title": "Test subject 1",
                  "grade": 10,
                  "image": "http://placehold.it/300x300"
                },
                {
                  "id": 2,
                  "title": "Test subject 2",
                  "grade": 11,
                  "image": "http://placehold.it/300x300"
                },
                {
                  "id": 3,
                  "title": "Test subject 3",
                  "grade": 12,
                  "image": "http://placehold.it/300x300"
                }
              ]
            }
          ''', 200);
      });

      List<Subject> subjects = await getSubjectsByUser(client: client);
      expect(subjects.length, 3);
      //expect(subjects[0].id, 1);
      expect(subjects[2].title, 'Test subject 3');
      expect(subjects[1].grade, 11);
      expect(subjects[2].image, 'http://placehold.it/300x300');
    });

    test('should throw BadResponse error when data is missing', () async {
      SharedPreferences.setMockInitialValues({});
      SharedPreferences pref = await SharedPreferences.getInstance();
      pref.setString('user_token', 'value');
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
      SharedPreferences.setMockInitialValues({});
      SharedPreferences pref = await SharedPreferences.getInstance();
      pref.setString('user_token', 'value');
      int id = 1;
      final client = httpTest.MockClient((request) async {
        return http.Response('', 400);
      });
      expect(await () => getSubjectsByUser(client: client), throwsException);
    });
  });
}
