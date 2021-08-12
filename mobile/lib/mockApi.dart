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
          "grade": 10,
          "mark": 20
        },
        {
          "id": 2,
          "title": "Geography Mock",
          "grade": 11,
          "mark": 50
        },
        {
          "id": 3,
          "title": "Life Orientation Mock",
          "grade": 12,
          "mark": 39
        },
        {
          "id": 3,
          "title": "Physics Mock",
          "grade": 12,
          "mark": 22
        },
        {
          "id": 3,
          "title": "Chemistry Mock",
          "grade": 12,
          "mark": 90
        }
      ]
    }
  ''', 200);
}

Future<http.Response> getGradesByUserClient(request) async {
  return http.Response('''
    {
      "data": [
        {
          "title": "Maths Mock",
          //As a percentage
          "mark": 10,
          "Lessons": [
            {
              "title":"Math Lesson 1",
              "mark": 20,
              "quiz": [
                //quiz 1
                {
                  "studentmark": 20,
                  "quiztotal": 40,
                  "title":"quiz 1"
                },
                 //quiz 1
                {
                  "mark": 20,
                  "quiztotal": 40,
                  "title":"quiz 2"
                },
              //lesson 2
              {
              "title":"Math Lesson 2",
              "mark": 15,
              "quiz": [
                 //quiz 1
                {
                  "studentmark": 20,
                  "quiztotal": 40,
                  "title":"quiz 1"
                },
                 //quiz 1
                {
                  "studentmark": 20,
                  "quiztotal": 40,
                  "title":"quiz 1"
                }
              ] //end of quiz 1 array
            },
          ] //end of lesson array
        },
        //subject 2
        {
          "title": "Geography Mock",
          //As a percentage
          "mark": 10,
          "Lessons": [
            {
              "title":"Geography Lesson 1",
              "mark": 20,
              "quiz": [
                {
                  "studentmark": 20,
                  "quiztotal": 40,
                  "title":"quiz 1"
                },
                {
                  "studentmark": 20,
                  "quiztotal": 40,
                  "title":"quiz 1"
                },
                {
              "title":"Geography Lesson 2",
              "mark": 15,
              "quiz": [
                {
                  "studentmark": 20,
                  "quiztotal": 40,
                  "title":"quiz 1"
                },
                {
                  "studentmark": 20,
                  "quiztotal": 40,
                  "title":"quiz 1"
                }
              ]
            },
          ]
        },  
      ]
    }
  ''', 200);
}
