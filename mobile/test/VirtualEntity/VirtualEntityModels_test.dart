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
          "question": "Is this a question?",
        }
      ''';
      Question question = Question.fromJson(jsonDecode(json));
      expect(question.id, 1);
      expect(question.type, QuestionType.TrueFalse);
      expect(question.correctAnswer, '');
      expect(question.options, null);
    });
  });
}