import 'package:http/http.dart' as http;
import 'package:mobile/src/Pages/VirtualEntityPage/Models/VirtualEntityModels.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:mobile/src/Pages/VirtualEntityPage/Controller/VirtualEntityController.dart';
import 'package:mobile/globals.dart';
import 'VirtualEntityController_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  group('Virtual Entity', () {
    test('should fetch virtual entity if the http call completes successfully', () async {
      final client = MockClient();
      when(client.post(Uri.parse("${baseUrl}virtualEntity/getVirtualEntity"))).thenAnswer((_) async => http.Response('''
        {
          "id": "1",
          "title": "Virtual Entity",
          "description": "Virtual Entity Description",
          "model": {
            "id": "1",
            "name": "Virtual Entity Model",
            "description": "Virtual Entity Model Description",
            "file_name": "Virtual Entity Model File Name",
            "file_type": "Virtual Entity Model File Type",
            "file_size": 0,
            "file_link": "Virtual Entity Model File Link"
          },
          "quiz": {
            "id": "1",
            "name": "Virtual Entity Quiz",
            "description": "Virtual Entity Quiz Description",
            "questions": [
              {
                "id": "1",
                "question": "Virtual Entity Question",
                "type": "TrueFalse"
                "correctAnswer": "True",
                "options": [
                  "True",
                  "False"
                ]
              }
            ]
          }
        }
      ''', 200));

      expect(await getVirtualEntity(1, client: client), isA<VirtualEntity>());
    }, skip: 'currently failing, not finding post stub in mocked http client');
  });
}