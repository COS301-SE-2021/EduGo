import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:test/test.dart';
import 'package:mobile/src/Pages/VirtualEntityPage/Models/VirtualEntityModels.dart';

void main() {
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

    test('should throw an error when invalid json is given', () {
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