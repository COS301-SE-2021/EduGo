import 'package:http/http.dart' as http;

Future<http.Response> getQuestionsByQuizId(request) async {
  return http.Response('''
    {
      "data": 
      [
        {
          "id": 1,
          "type": "TrueFalse",
          "question": "Select True",
          "correctAnswer": "True",
          "options": ["True","False"],
        },
        {
          "id": 2,
          "type": "MultipleChoice",
          "question": "Select A",
          "correctAnswer": "A",
          "options": ["A","B","C"],
        },
        {
          "id": 3,
          "type": "MultipleChoice",
          "question": "Select B",
          "correctAnswer": "B",
          "options": ["A","B","C"],
        },
        {
          "id": 4,
          "type": "TrueFalse",
          "question": "Select False",
          "correctAnswer": "False",
          "options": ["True","False"],
        },
      ]
    }
  ''', 200);
}

Future<http.Response> getQuizesByLesson(request) async {
  return http.Response('''
  {
    "data": [
      {
      "id" : 0,
      "title": "Quiz 1",
      "description": "Quiz 1 d",
      "questions": [
        {
          "id": 1,
          "type": "TrueFalse",
          "question": "Select True",
          "correctAnswer": "True",
          "options": ["True","False"]
        },
        {
          "id": 2,
          "type": "MultipleChoice",
          "question": "Select A",
          "correctAnswer": "A",
          "options": ["A","B","C"]
        },
        {
          "id": 3,
          "type": "MultipleChoice",
          "question": "Select B",
          "correctAnswer": "B",
          "options": ["A","B","C"]
        },
        {
          "id": 4,
          "type": "TrueFalse",
          "question": "Select False",
          "correctAnswer": "False",
          "options": ["True","False"]
        }
       ]
      },
      {
      "id" : 1,
      "title": "Quiz 2",
      "description": "Quiz 2 d",
      "questions": [
        {
          "id": 1,
          "type": "TrueFalse",
          "question": "Select False",
          "correctAnswer": "False",
          "options": ["True","False"]
        },
        {
          "id": 2,
          "type": "MultipleChoice",
          "question": "Select A",
          "correctAnswer": "A",
          "options": ["A","B","C"]
        },
        {
          "id": 3,
          "type": "MultipleChoice",
          "question": "Select B",
          "correctAnswer": "B",
          "options": ["A","B","C"]
        },
        {
          "id": 4,
          "type": "TrueFalse",
          "question": "Select False",
          "correctAnswer": "False",
          "options": ["True","False"]
        }
      ]
      }
    ]
  }
   ''', 200);
}

Future<http.Response> getLessonsBySubjectClient(request) async {
  return http.Response('''
    {
      "data": [
        {
          "id": 1,
          "title": "Lesson test 1 ",
          "description": "This is the first lesson. We will learn about the importance of the democratic extinction of dinasours. One day, the patriachal empire of pandas wiol return.",
          "lessonCompleted": "true"
        },
        {
          "id": 2,
          "title": "Lesson test 2",
          "description": "This is the second lesson...",
          "lessonCompleted": "true"
        },
        {
          "id": 3,
          "title": "Lesson test 3",
          "description": "This is the third lesson..",
          "lessonCompleted": "false"
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
          "educator": "Mr Harry",
          "title": "Maths 101",
          "grade": 10,
          "mark": 20
        },
        {
          "id": 2,
          "educator": "Mrs Kim",
          "title": "Geography 101",
          "grade": 11,
          "mark": 50
        },
        {
          "id": 3,
          "educator": "Mrs Naledi",
          "title": "Life Orientation 101",
          "grade": 12,
          "mark": 39
        },
        {
          "id": 3,
          "educator": "Prof NoahtheClown",
          "title": "Physics 101",
          "grade": 12,
          "mark": 22
        },
        {
          "id": 3,
          "educator": "Dr Simekani",
          "title": "Chemistry 101",
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
      "subjects": 
      [
        {
          "id": 1,
          "subjectName": "Maths 101",
          "gradeAchieved": 10,
          "lessonGrades": 
          [
            {
              "id": 1,
              "lessonName": "Math Lesson 1",
              "gradeAchieved": 20,
              "quizGrades": 
              [
                {
                  "id": 1,
                  "student_score": 67,
                  "quiz_total": 89
                },
                {
                  "id": 2,
                  "student_score": 20,
                  "quiz_total": 40
                }
              ]
            },
            {
              "id": 2,
              "lessonName": "Math Lesson 2",
              "gradeAchieved": -1,
              "quizGrades": 
              [
                {
                  "id": 1,
                  "student_score": 29,
                  "quiz_total": 39
                },
                {
                  "id": 2,
                  "student_score": 12,
                  "quiz_total": 87
                }
              ]
            }
            
          ] 
        },
        {
          "id": 2,
          "subjectName": "Geography Mock",
          "gradeAchieved": 87,
          "lessonGrades": 
          [
            {
              "id": 1,
              "lessonName": "Geography Lesson 1",
              "gradeAchieved": 90,
              "quizGrades": 
              [
                {
                  "id": 1,
                  "student_score": 80,
                  "quiz_total": 100
                },
                { 
                  "id": 2,
                  "student_score": 22,
                  "quiz_total": 48
                }
              ]
            },
            {
              "id": 2,
              "lessonName": "Geography Lesson 2",
              "gradeAchieved": 18,
              "quizGrades": 
              [
                {
                  "id": 1,
                  "student_score": 76,
                  "quiz_total": 80
                },
                {
                  "id": 2,
                  "student_score": 19,
                  "quiz_total": 120
                }
              ]
            }
          ] 
        },
        {
          "id": 3,
          "subjectName": "Physics 101",
          "gradeAchieved": 65,
          "lessonGrades": 
          [
            {
              "id": 1,
              "lessonName": "Physics Lesson 1",
              "gradeAchieved": 20,
              "quizGrades": 
              [
                {
                  "id": 1,
                  "student_score": 67,
                  "quiz_total": 89
                },
                {
                  "id": 2,
                  "student_score": 20,
                  "quiz_total": 40
                }
              ]
            },
            {
              "id": 2,
              "lessonName": "Physics Lesson 2",
              "gradeAchieved": 15,
              "quizGrades": 
              [
                {
                  "id": 1,
                  "student_score": 29,
                  "quiz_total": 39
                },
                {
                  "id": 2,
                  "student_score": 12,
                  "quiz_total": 87
                }
              ]
            }
          ] 
        },
        {
          "id": 4,
          "subjectName": "Biology 101",
          "gradeAchieved": -1,
          "lessonGrades": 
          [
            {
              "id": 1,
              "lessonName": "Biology Lesson 1",
              "gradeAchieved": -1,
              "quizGrades": 
              [
                {
                  "id": 1,
                  "student_score": -1,
                  "quiz_total": -1
                },
                {
                  "id": 2,
                  "student_score": -1,
                  "quiz_total": -1
                }
              ]
            },
            {
              "id": 2,
              "lessonName": "Biology Lesson 2",
              "gradeAchieved": -1,
              "quiquizGradeszzes": 
              [
                {
                  "id": 1,
                  "student_score": -1,
                  "quiz_total": -1
                },
                {
                  "id": 2,
                  "student_score": -1,
                  "quiz_total": -1
                }
              ]
            }
          ] 
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

Future<http.Response> verify(request) async {
  return http.Response('ok', 200);
}

Future<http.Response> register(request) async {
  return http.Response('ok', 200);
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
