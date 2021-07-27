import 'dart:convert';

import 'package:mobile/src/Pages/SubjectsPage/Models/SubjectModels.dart';
import 'package:test/test.dart';

void main() {
  group('Subject', () {
    test('should correctly instantiate a subject object from a json string', () {
      String json = '''
        {
          "id": 1,
          "title": "Test Subject",
          "grade": 9
        }
      ''';
      Subject subject = Subject.fromJson(jsonDecode(json));
      expect(subject.id, 1);
      expect(subject.title, 'Test Subject');
      expect(subject.grade, 9);
    });

    test('should set grade to 0 when grade is omitted', () {
      String json = '''
        {
          "id": 1,
          "title": "Test Subject"
        }
      ''';
      Subject subject = Subject.fromJson(jsonDecode(json));
      expect(subject.grade, 0);
    });
  });
}