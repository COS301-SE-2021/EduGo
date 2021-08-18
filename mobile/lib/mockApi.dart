import 'package:http/http.dart' as http;

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
