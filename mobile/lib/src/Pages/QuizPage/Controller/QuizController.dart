/**
 * This is the quizz controller. It handles the api calls to get the quizzes
 * for a lesson.The endpoint is getSubjectsByUser which return a list 
 * of subjects. That list is converted from a string to a json object. 
*/

import 'dart:convert';
import 'package:mobile/mockApi.dart' as mockApi;
import 'package:http/testing.dart' as httpMock;
import 'package:http/http.dart' as http;
import 'package:mobile/globals.dart';
import 'package:mobile/src/Exceptions.dart';
import 'package:mobile/src/Pages/QuizPage/Model/Quiz.dart';
import 'package:mobile/src/Pages/QuizPage/Model/QuizModel.dart';
import 'package:momentum/momentum.dart';
import 'package:shared_preferences/shared_preferences.dart';

/*------------------------------------------------------------------------------
 *                          Quizz controller
 *------------------------------------------------------------------------------
 */

//Main function that is used to get the quizzes.
//It takes in a lesson id
Future<List<Quiz>> getQuizesByLesson(int id,
    {required http.Client client}) async {
  final preferences = await SharedPreferences.getInstance();
  final String? token = preferences.getString("user_token") ?? null;
  if (token == null) throw NoToken();
  final response =
      await client.post(Uri.parse("${baseUrl}virtualEntity/getQuizesByLesson"),
          headers: <String, String>{
            'Content-Type': 'application/json',
            'Authorization': token,
          },
          body: jsonEncode(<String, int>{"id": id}));

  if (response.statusCode == 200) {
    Map<String, dynamic> json = jsonDecode(response.body);
    if (json['data'] != null) {
      List<Quiz> quizes =
          (json['data'] as List).map((e) => Quiz.fromJson(e)).toList();
      return quizes;
    } else
      throw new BadResponse('No data property');
  }
  throw Exception('Not a code 200');
}

//This is the other main function used for the quizzes. It sends the
//student's submitteds answers back to the database. In the body, it
//needs the lesson id (as an int), the quizz id (as an int) and
//the answers for that quiz's questions(as a list)
Future<void> answerQuiz(int lesson_id, int quiz_id, List<String> answers,
    {required http.Client client}) async {
  final preferences = await SharedPreferences.getInstance();
  final String? token = preferences.getString("user_token") ?? null;

  if (token == null) throw NoToken();
  final response =
      await client.post(Uri.parse("${baseUrl}virtualEntity/answerQuiz"),
          headers: <String, String>{
            'Content-Type': 'application/json',
            'Authorization': token,
          },
          body: jsonEncode(<String, dynamic>{
            "lesson_id": lesson_id,
            "quiz_id": quiz_id,
            "answers": answers,
          }));
  if (response.statusCode == 200) {
    return;
  }
  throw Exception('Not a code 200');
}

//QuizController constructor with a default value of mock set to false
class QuizController extends MomentumController<QuizModel> {
  QuizController({this.mock = false});

  //Used to determine if mock data should be used
  //or real data from the api call
  bool mock;

  //Instantiale the quiz model
  @override
  QuizModel init() {
    return QuizModel(this, quizzes: []);
  }

  //Populate the quiz model with the quizes returned from the getQuizzes call
  //Wrap it in a function so that we can explicitaldy call it on page reload
  //i.e not a bootstrap async function
  Future<void> getQuizzes(int lessonId) {
    return getQuizesByLesson(lessonId,
            client: mock
                ? httpMock.MockClient(mockApi.getQuizesByLesson)
                : http.Client())
        .then((value) {
      //get the quizzes
      model.update(quizzes: value);
    });
  }

  //This function is going to be used on submit button call
  //when quiz has ended to send the student's answers back.
  //Send the lessonid, quiz id and answers as a list
  Future<void> answerQuizByLessonId(
    int lessonId,
    int quiz_id,
    List<String> answers,
  ) {
    return answerQuiz(lessonId, quiz_id, answers, client: http.Client())
        .then((value) {});
  }
}
