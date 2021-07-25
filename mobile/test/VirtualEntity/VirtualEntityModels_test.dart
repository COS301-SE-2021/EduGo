import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:test/test.dart';
import 'package:mobile/src/Pages/VirtualEntityPage/Models/VirtualEntityModels.dart';

void main() {
  group('Question', () {
    test('should correctly instantiate a basic question object from a json string', () {
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

    test('should correctly instantiate a more complex question object from a json string', () {
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
    });
  });

  group("Quiz", () {
    String title = 'Quiz Title';
    String description = 'Quiz Description';
    test('should correctly instantiate a basic quiz object from a json string', () {
      String json = '''
        {
          "id": 1,
          "title": "${title}",
          "description": "${description}"
        }
      ''';
      Quiz quiz = Quiz.fromJson(jsonDecode(json));
      expect(quiz.id, 1);
      expect(quiz.title, title);
      expect(quiz.description, description);
      expect(quiz.questions, null);
    });

    test('should correctly instantiate a quiz object from a json string with defaults', () {
      String json = '''
        {
          "id": 1,
          "title": "${title}"
        }
      ''';
      Quiz quiz = Quiz.fromJson(jsonDecode(json));
      expect(quiz.id, 1);
      expect(quiz.title, title);
      expect(quiz.description, '');
      expect(quiz.questions, null);
    });

    test('should correctly instantiate a more complex quiz object from a json string', () {
      String json = '''
        {
          "id": 1,
          "title": "${title}",
          "description": "${description}",
          "questions": [
            {
              "id": 1,
              "type": "TrueFalse",
              "question": "Is this a question?",
              "correctAnswer": "True",
              "options": [
                "True",
                "False"
              ]
            },
            {
              "id": 2,
              "type": "MultipleChoice",
              "question": "Is this a multiple choice question?",
              "correctAnswer": "B",
              "options": [
                "A",
                "B",
                "C",
                "D"
              ]
            }
          ]
        }
      ''';
      Quiz quiz = Quiz.fromJson(jsonDecode(json));
      expect(quiz.id, 1);
      expect(quiz.title, title);
      expect(quiz.description, description);
      expect(quiz.questions!.length, 2);
      expect(quiz.questions![0].id, 1);
      expect(quiz.questions![0].type, QuestionType.TrueFalse);
      expect(quiz.questions![0].correctAnswer, 'True');
      expect(quiz.questions![0].options, ['True', 'False']);
      expect(quiz.questions![1].id, 2);
      expect(quiz.questions![1].type, QuestionType.MultipleChoice);
      expect(quiz.questions![1].correctAnswer, 'B');
      expect(quiz.questions![1].options, ['A', 'B', 'C', 'D']);
    });
  });

  group("Model" , () {
    test('should correctly instantiate a basic model object from a json string', () {
      String json = '''
        {
          "name": "Model Name",
          "description": "Model description",
          "file_name": "File name",
          "file_link": "File link",
          "file_type": "File type",
          "file_size": 0
        }
      ''';
      Model model = Model.fromJson(jsonDecode(json));
      expect(model.name, 'Model Name');
      expect(model.description, 'Model description');
      expect(model.file_name, 'File name');
      expect(model.file_link, 'File link');
      expect(model.file_type, 'File type');
      expect(model.file_size, 0);
    });

    test('that is incorrectly formatted should throw error', () {
      String json = '''
        {
          "name": "Model Name",
          "description": "Model description",
          "file_name": "File name",
          "file_link": "File link",
          "file_type": "File type",
        }
      ''';
      expect(() => Model.fromJson(jsonDecode(json)), throwsA(isA<FormatException>()));
    });

    test('should throw an error due to missing required property', () {
      String json = '''
        {
          "description": "Model description",
          "file_name": "File name",
          "file_link": "File link",
          "file_type": "File type"
        }
      ''';
      expect(() => Model.fromJson(jsonDecode(json)), throwsA(isA<MissingRequiredKeysException>()));
    });
  });
}