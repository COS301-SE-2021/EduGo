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
      "id" : "0",
      "title": "Quiz 1"
      "description": "Quiz 1 d",
      "questions": [{
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
      },{
      "id" : "1",
      "title": "Quiz 2"
      "description": "Quiz 2 d",
      "questions": [{
          "id": 1,
          "type": "TrueFalse",
          "question": "Select False",
          "correctAnswer": "False",
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
          "title": "Lesson test 1",
          "description": "This is the first lesson..."
        },
        {
          "id": 2,
          "title": "Lesson test 2",
          "description": "This is the second lesson..."
        },
        {
          "id": 3,
          "title": "Lesson test 3",
          "description": "This is the third lesson.."
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
      "data": 
      [
        {
          "id": 1,
          "title": "Maths 101",
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
                  "title": "quiz 1",
                  "studentAnswers": 
                  [
                    "A", "B", "A", "D"
                  ],
                  "correctAnswers":
                  [
                  "C", "B", "B", "D"
                  ]
                },
                {
                  "id": 2,
                  "studentMark": 20,
                  "quizTotal": 40,
                  "title": "quiz 2",
                  "studentAnswers": 
                  [
                    "A", "K", "U", "D"
                  ],
                  "correctAnswers":
                  [
                  "S", "B", "J", "D"
                  ]
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
                  "title": "quiz 1",
                  "studentAnswers": 
                  [
                    "N", "D", "L", "D"
                  ],
                  "correctAnswers":
                  [
                    "A", "B", "K", "D"
                  ]
                },
                {
                  "id": 2,
                  "studentMark": 12,
                  "quizTotal": 87,
                  "title": "quiz 1",
                  "studentAnswers": 
                  [
                    "Q", "B", "L", "D"
                  ],
                  "correctAnswers":
                  [
                    "A", "L", "A", "D"
                  ]
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
                  "title": "quiz 1",
                  "studentAnswers": 
                  [
                    "L", "K", "A", "D"
                  ],
                  "correctAnswers":
                  [
                    "A", "B", "A", "D"
                  ]
                },
                { 
                  "id": 2,
                  "studentMark": 22,
                  "quizTotal": 48,
                  "title": "quiz 2",
                  "studentAnswers": 
                  [
                    "B", "B", "B", "D"
                  ],
                  "correctAnswers":
                  [
                    "B", "B", "A", "D"
                  ]
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
                  "title": "quiz 1",
                  "studentAnswers": 
                  [
                    "S", "B", "S", "D"
                  ],
                  "correctAnswers":
                  [
                    "L", "O", "A", "D"
                  ]
                },
                {
                  "id": 2,
                  "studentMark": 19,
                  "quizTotal": 120,
                  "title": "quiz 2",
                  "studentAnswers": 
                  [
                    "L", "B", "A", "S"
                  ],
                  "correctAnswers":
                  [
                    "A", "T", "A", "U"
                  ]
                }
              ]
            }
          ] 
        },
        {
          "id": 3,
          "title": "Physics 101",
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
                  "title": "quiz 1",
                  "studentAnswers": 
                  [
                    "S", "B", "A", "D"
                  ],
                  "correctAnswers":
                  [
                    "A", "S", "A", "D"
                  ]
                },
                {
                  "id": 2,
                  "studentMark": 20,
                  "quizTotal": 40,
                  "title": "quiz 2",
                  "studentAnswers": 
                  [
                    "D", "B", "A", "D"
                  ],
                  "correctAnswers":
                  [
                    "U", "B", "A", "D"
                  ]
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
                  "title": "quiz 1",
                  "studentAnswers": 
                  [
                    "A", "B", "A", "D"
                  ],
                  "correctAnswers":
                  [
                    "A", "B", "A", "D"
                  ]
                },
                {
                  "id": 2,
                  "studentMark": 12,
                  "quizTotal": 87,
                  "title": "quiz 1",
                  "studentAnswers": 
                  [
                  "A", "B", "A", "D"
                  ],
                  "correctAnswers":
                  [
                  "A", "B", "A", "D"
                  ]
                }
              ]
            }
          ] 
        },
        {
          "id": 4,
          "title": "Biology 101",
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
                  "title": "quiz 1",
                  "studentAnswers": 
                  [
                  "A", "B", "A", "D"
                  ],
                  "correctAnswers":
                  [
                  "A", "B", "A", "D"
                  ]

                },
                {
                  "id": 2,
                  "studentMark": -1,
                  "quizTotal": -1,
                  "title": "quiz 2",
                  "studentAnswers": 
                  [
                  "A", "B", "A", "D"
                  ],
                  "correctAnswers":
                  [
                  "A", "B", "A", "D"
                  ]
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
                  "title": "quiz 1",
                  "studentAnswers": 
                  [
                  "A", "B", "A", "D"
                  ],
                  "correctAnswers":
                  [
                  "A", "B", "A", "D"
                  ]
                },
                {
                  "id": 2,
                  "studentMark": -1,
                  "quizTotal": -1,
                  "title": "quiz 1",
                  "studentAnswers": 
                  [
                  "A", "B", "A", "D"
                  ],
                  "correctAnswers":
                  [
                  "A", "B", "A", "D"
                  ]
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
