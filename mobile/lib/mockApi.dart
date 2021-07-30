import 'package:http/http.dart' as http;
import 'package:http/testing.dart' as mock;

final getLessonsBySubjectClient = mock.MockClient((request) async {
  return http.Response('''
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
});

final getSubjectsByUserClient = mock.MockClient((request) async {
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
        },
        {
          "id": 4,
          "title": "Test subject 4",
          "grade": 12
        },
        {
          "id": 5,
          "title": "Test subject 5",
          "grade": 11
        }
      ]
    }
  ''', 200);
});
