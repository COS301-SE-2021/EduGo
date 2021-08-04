import 'package:http/http.dart' as http;
import 'package:http/testing.dart' as mock;

Future<http.Response> getLessonsBySubjectClient(request) async {
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
}

Future<http.Response> getSubjectsByUserClient(request) async {
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
        }
      ]
    }
  ''', 200);
}

Future<http.Response> loginClient(request) async {
  return http.Response('''
    {
      "token": "abcdefghijklmopqrstuvwxyz"
    }
  ''', 200);
}

Future<http.Response> loadUserClient(request) async {
  return http.Response('''
    {
      "id": 1,
      "username": "test",
      "firstName: "Test",
      "lastName": "User",
      "email": "test@test.com",
      "type": "Student"
    }
  ''', 200);
}

Future<http.Response> getUpcomingLessons(request) async {
  return http.Response('''
    {
      "lessons": [
          {
              "id": 7,
              "title": "Algebra",
              "startTime": "2021-08-31T09:30:00.000Z",
              "endTime": "2021-08-31T10:00:00.000Z",
              "description": "The algrbra stuff",
              "subject": "Maths"
          },
          {
              "id": 8,
              "title": "Linear Patterns",
              "startTime": "2021-08-31T10:00:00.000Z",
              "endTime": "2021-08-31T10:30:00.000Z",
              "description": "y=mx something something",
              "subject": "Maths"
          },
          {
              "id": 10,
              "title": "Shakespeare",
              "startTime": "2021-08-31T11:00:00.000Z",
              "endTime": "2021-08-31T11:30:00.000Z",
              "description": "To be or not to be",
              "subject": "English"
          },
          {
              "id": 13,
              "title": "Java",
              "startTime": "2021-08-31T11:30:00.000Z",
              "endTime": "2021-08-31T12:00:00.000Z",
              "description": "You might need an ultrawide for the errors",
              "subject": "Information Technology"
          },
          {
              "id": 9,
              "title": "Algebra",
              "startTime": "2021-08-31T12:00:00.000Z",
              "endTime": "2021-08-31T12:30:00.000Z",
              "description": "More algebra",
              "subject": "Maths"
          },
          {
              "id": 12,
              "title": "Delphi",
              "startTime": "2021-08-31T13:00:00.000Z",
              "endTime": "2021-08-31T13:30:00.000Z",
              "description": "Before or after the begin?",
              "subject": "Information Technology"
          },
          {
              "id": 11,
              "title": "Shakespeare 2",
              "startTime": "2021-08-31T14:00:00.000Z",
              "endTime": "2021-08-31T14:30:00.000Z",
              "description": "Even more To be or not to be",
              "subject": "English"
          }
      ]
  }
  ''', 200);
}