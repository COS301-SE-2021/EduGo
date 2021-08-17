import 'dart:convert';

import 'package:mobile/globals.dart';
import 'package:mobile/src/Exceptions.dart';
import 'package:mobile/src/Pages/QuizPage/Model/QuizModel.dart';
import 'package:mobile/mockApi.dart' as mockApi;
import 'package:http/http.dart' as http;
import 'package:http/testing.dart' as httpMock;
import 'package:mobile/src/Pages/VirtualEntityPage/Models/VirtualEntityModels.dart';
import 'package:momentum/momentum.dart';

class QuizController extends MomentumController<QuizModel> {
  QuizController({this.mock = false});
  bool mock;

  //List<Question> questions = [];
  @override
  QuizModel init() {
    return QuizModel(this, id: 0, title: '', description: '', questions: []);
  }

  Future<List<Question>> getQuestions({required http.Client client}) async {
    final response = await client.post(
      Uri.parse("${baseUrl}quiz/getQuestionsByQuizId"),
      headers: <String, String>{'Content-Type': 'application/json'},
    ); //convert it to a json object, else throw an exception
    if (response.statusCode == 200) {
      Map<String, dynamic> json = jsonDecode(response.body);
      if (json['data'] != null) {
        List<Question> questions =
            (json['data'] as List).map((e) => Question.fromJson(e)).toList();
        return questions;
      } else
        throw new BadResponse('No data property');
    }
    throw Exception('Not a code 200');
  }

  @override
  Future<void> bootstrapAsync() {
    return getQuestions(
            client: mock
                ? httpMock.MockClient(mockApi.getQuestionsByQuizId)
                : http.Client())
        .then((value) {
      model.update(questions: value);
    });
  }
}
