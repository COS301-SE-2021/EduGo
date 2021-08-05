import 'package:http/http.dart' as http;
import 'package:http/testing.dart' as mock;

Future<http.Response> getLessonsBySubjectClient(request) async {
  return http.Response('''
    {
      "data": [
        {
          "id": 1,
          "title": "Lesson test 1",
          "description": "This is lesson 1",
          "startTime": "10:00",
          "endTime": "11:00"
        },
        {
          "id": 2,
          "title": "Lesson test 2",
          "description": "This is lesson 2",
          "startTime": "11:00",
          "endTime": "12:00"
        },
        {
          "id": 3,
          "title": "Lesson test 3",
          "description": "This is lesson 3",
          "startTime": "12:00",
          "endTime": "13:00"
        }
      ]
    }
  ''', 200);
}

Future<http.Response> getSubjectsByUserClient(request) async {
  return http.Response('''
    {
      "data": [
        {
          "id": 1,
          "title": "Maths Mock",
          "grade": 10
        },
        {
          "id": 2,
          "title": "Geography Mock",
          "grade": 11
        },
        {
          "id": 3,
          "title": "Life Orientation Mock",
          "grade": 12
        },
        {
          "id": 3,
          "title": "Physics Mock",
          "grade": 12
        },
        {
          "id": 3,
          "title": "Chemistry Mock",
          "grade": 12
        }
      ]
    }
  ''', 200);
}
