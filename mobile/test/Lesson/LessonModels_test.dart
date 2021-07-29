import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:mobile/src/Pages/LessonsPage/Models/Lesson.dart';
import 'package:test/test.dart';

void main() {
  group('Lesson', () {
    test('should correctly instantiate a lesson object from a json string', () {
      String json = '''
        {
          "id": 1,
          "title": "Lesson 1",
          "description": "This is lesson 1",
          "startTime": "10:00",
          "endTime": "11:00"
        }
      ''';

      Lesson lesson = Lesson.fromJson(jsonDecode(json));
      expect(lesson.id, 1);
      expect(lesson.title, 'Lesson 1');
      expect(lesson.description, 'This is lesson 1');
      expect(lesson.startTime, '10:00');
      expect(lesson.endTime, '11:00');
    });

    test('should set description to an empty string when omitted', () {
      String json = '''
        {
          "id": 1,
          "title": "Lesson 1",
          "startTime": "10:00",
          "endTime": "11:00"
        }
      ''';

      Lesson lesson = Lesson.fromJson(jsonDecode(json));
      expect(lesson.description, '');
    });

    test('should set startTime to an empty string when omitted', () {
      String json = '''
        {
          "id": 1,
          "title": "Lesson 1",
          "description": "This is lesson 1",
          "endTime": "11:00"
        }
      ''';

      Lesson lesson = Lesson.fromJson(jsonDecode(json));
      expect(lesson.startTime, '');
    });

    test('should set endTime to an empty string when omitted', () {
      String json = '''
        {
          "id": 1,
          "title": "Lesson 1",
          "description": "This is lesson 1",
          "startTime": "10:00"
        }
      ''';

      Lesson lesson = Lesson.fromJson(jsonDecode(json));
      expect(lesson.endTime, '');
    });

    test('should throw an exception if the id is missing', () {
      String json = '''
        {
          "title": "Lesson 1",
          "description": "This is lesson 1",
          "startTime": "10:00",
          "endTime": "11:00"
        }
      ''';

      expect(() => Lesson.fromJson(jsonDecode(json)), throwsA(isA<MissingRequiredKeysException>()));
    });

    test('should throw an exception if the title is missing', () {
      String json = '''
        {
          "id": 1,
          "description": "This is lesson 1",
          "startTime": "10:00",
          "endTime": "11:00"
        }
      ''';

      expect(() => Lesson.fromJson(jsonDecode(json)), throwsA(isA<MissingRequiredKeysException>()));
    });
  });
}