import 'dart:convert';

import 'package:test/test.dart';
import 'package:mobile/src/Pages/VirtualEntityPage/Models/VirtualEntityModels.dart';

void main() {
  group('Question', () {
    test('Should correctly instantiate a basic question object from a json string', () {
      String json = '''
        {
          "id": 1,
          "type": "TrueFalse",
          "question": "Is this a question?"
        }
      ''';
      Question question = Question.fromJson(jsonDecode(json));
      expect(question.id, 1);
      expect(question.type, QuestionType.TrueFalse);
      expect(question.correctAnswer, '');
      expect(question.options, null);
    });

    test('Should correctly instantiate a more complex question object from a json string', () {
      String json = '''
        {
          "id": 1,
          "type": "TrueFalse",
          "question": "Is this a question?",
          "correctAnswer": "True",
          "options": [
            "True",
            "False"
          ]
        }
      ''';
      Question question = Question.fromJson(jsonDecode(json));
      expect(question.id, 1);
      expect(question.type, QuestionType.TrueFalse);
      expect(question.correctAnswer, 'True');
      expect(question.options, ['True', 'False']);
      expect(question.options!.length, 2);
    });
  });

  group("Quiz", () {
    test('Should correctly instantiate a basic quiz object from a json string', () {
      String json = '''
        {
          "id": 1,
          "title": "Quiz Title",
          
      ''';
    });
  });
}