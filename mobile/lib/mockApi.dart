import 'package:http/http.dart' as http;

Future<http.Response> getLessonsBySubjectClient(request) async {
  return http.Response('''
    {
      "data": [
        {
          "id": 1,
          "title": "Lesson test 1",
          "description": "This is lesson 1"
        },
        {
          "id": 2,
          "title": "Lesson test 2",
          "description": "This is lesson 2"
        },
        {
          "id": 3,
          "title": "Lesson test 3",
          "description": "This is lesson 3"
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
          "title": "Maths 101-Mock",
          "grade": 10,
          "mark": 20
        },
        {
          "id": 2,
          "title": "Geography 101-Mock",
          "grade": 11,
          "mark": 50
        },
        {
          "id": 3,
          "title": "Life Orientation 101-Mock",
          "grade": 12,
          "mark": 39
        },
        {
          "id": 3,
          "title": "Physics 101-Mock",
          "grade": 12,
          "mark": 22
        },
        {
          "id": 3,
          "title": "Chemistry 101-Mock",
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
      "data": 
      [
        {
          "id": 1,
          "title": "Maths 101-Mock",
          "mark": 10,
          "lessons": 
          [
            {
              "id": 1,
              "title": "Math Lesson 1",
              "mark": 20,
              "quizzes": 
              [
                {
                  "id": 1,
                  "studentMark": 67,
                  "quizTotal": 89,
                  "title": "quiz 1"
                },
                {
                  "id": 2,
                  "studentMark": 20,
                  "quizTotal": 40,
                  "title": "quiz 2"
                }
              ]
            },
            {
              "id": 2,
              "title": "Math Lesson 2",
              "mark": 15,
              "quizzes": 
              [
                {
                  "id": 1,
                  "studentMark": 29,
                  "quizTotal": 39,
                  "title": "quiz 1"
                },
                {
                  "id": 2,
                  "studentMark": 12,
                  "quizTotal": 87,
                  "title": "quiz 1"
                }
              ]
            }
          ] 
        },
        {
          "id": 2,
          "title": "Geography Mock",
          "mark": 87,
          "lessons": 
          [
            {
              "id": 1,
              "title": "Geography Lesson 1",
              "mark": 90,
              "quizzes": 
              [
                {
                  "id": 1,
                  "studentMark": 80,
                  "quizTotal": 100,
                  "title": "quiz 1"
                },
                { 
                  "id": 2,
                  "studentMark": 22,
                  "quizTotal": 48,
                  "title": "quiz 2"
                }
              ]
            },
            {
              "id": 2,
              "title": "Geography Lesson 2",
              "mark": 18,
              "quizzes": 
              [
                {
                  "id": 1,
                  "studentMark": 76,
                  "quizTotal": 80,
                  "title": "quiz 1"
                },
                {
                  "id": 2,
                  "studentMark": 19,
                  "quizTotal": 120,
                  "title": "quiz 2"
                }
              ]
            }
          ] 
        },
        {
          "id": 3,
          "title": "Physics 101-Mock",
          "mark": 65,
          "lessons": 
          [
            {
              "id": 1,
              "title": "Physics Lesson 1",
              "mark": 20,
              "quizzes": 
              [
                {
                  "id": 1,
                  "studentMark": 67,
                  "quizTotal": 89,
                  "title": "quiz 1"
                },
                {
                  "id": 2,
                  "studentMark": 20,
                  "quizTotal": 40,
                  "title": "quiz 2"
                }
              ]
            },
            {
              "id": 2,
              "title": "Physics Lesson 2",
              "mark": 15,
              "quizzes": 
              [
                {
                  "id": 1,
                  "studentMark": 29,
                  "quizTotal": 39,
                  "title": "quiz 1"
                },
                {
                  "id": 2,
                  "studentMark": 12,
                  "quizTotal": 87,
                  "title": "quiz 1"
                }
              ]
            }
          ] 
        },
        {
          "id": 4,
          "title": "Biology 101-Mock",
          "mark": -1,
          "lessons": 
          [
            {
              "id": 1,
              "title": "Biology Lesson 1",
              "mark": -1,
              "quizzes": 
              [
                {
                  "id": 1,
                  "studentMark": -1,
                  "quizTotal": -1,
                  "title": "quiz 1"
                },
                {
                  "id": 2,
                  "studentMark": -1,
                  "quizTotal": -1,
                  "title": "quiz 2"
                }
              ]
            },
            {
              "id": 2,
              "title": "Biology Lesson 2",
              "mark": -1,
              "quizzes": 
              [
                {
                  "id": 1,
                  "studentMark": -1,
                  "quizTotal": -1,
                  "title": "quiz 1"
                },
                {
                  "id": 2,
                  "studentMark": -1,
                  "quizTotal": -1,
                  "title": "quiz 1"
                }
              ]
            }
          ] 
        }
      ]
    }
  ''', 200);
}
