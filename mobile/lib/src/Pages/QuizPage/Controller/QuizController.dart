import 'dart:convert';
import 'package:mobile/mockApi.dart' as mockApi;
import 'package:http/testing.dart' as httpMock;
import 'package:http/http.dart' as http;
import 'package:mobile/globals.dart';
import 'package:mobile/src/Exceptions.dart';
import 'package:mobile/src/Pages/QuizPage/Model/QuizModel.dart';
import 'package:mobile/src/Pages/QuizPage/Model/QuizPageModel.dart';
import 'package:momentum/momentum.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<List<Quiz>> getQuizesByLesson(int id,
    {required http.Client client}) async {
  final preferences = await SharedPreferences.getInstance();
  final String? token = preferences.getString("user_token") ?? null;
  //print(token);
  if (token == null) throw NoToken();
  final response =
      await client.post(Uri.parse("${baseUrl}virtualEntity/getQuizesByLesson"),
          headers: <String, String>{
            'Content-Type': 'application/json',
            'Authorization': token,
          },
          body: jsonEncode(<String, int>{"id": id}));
  //print(response.body);
  if (response.statusCode == 200) {
    Map<String, dynamic> json = jsonDecode(response.body);
    if (json['data'] != null) {
      List<Quiz> quizes =
          (json['data'] as List).map((e) => Quiz.fromJson(e)).toList();
      return quizes;
    } else
      throw new BadResponse('No data property');
  }
  //print(response.statusCode);
  throw Exception('Not a code 200');
}

Future<void> answerQuiz(int lesson_id, int quiz_id, List<Answer> answers,
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
  // print('ek is hier');
  // print('lessonId ' + lesson_id.toString());
  // print('quiz_id ' + quiz_id.toString());
  // print('answers:');
  // print(answers.toString());
  // for (var answer in answers) {
  //   print(answer.question_id.toString());
  //   print(answer.answer);
  // }
  // print(response);
  // print(response.body);
  // print(response.statusCode);
  if (response.statusCode == 200) {
    print('ok');
    return;
  }
  print('not ok');
  throw Exception('Not a code 200');
}

class QuizController extends MomentumController<QuizPageModel> {
  QuizController({this.mock = false});
  bool mock;

  @override
  QuizPageModel init() {
    return QuizPageModel(this, quizes: []);
  }

  Future<void> getQuizzes(int lessonId) {
    return getQuizesByLesson(lessonId,
            client: mock
                ? httpMock.MockClient(mockApi.getQuizesByLesson)
                : http.Client())
        .then((value) {
      //get the quizzes
      model.update(quizes: value);
    });
  }

  Future<void> answerQuizByLessonId(
    int lessonId,
    int quiz_id,
    List<Answer> answers,
  ) {
    return answerQuiz(lessonId, quiz_id, answers, client: http.Client())
        .then((value) {});
  }
}
