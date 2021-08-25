import 'dart:convert';
import 'package:mobile/mockApi.dart' as mockApi;
import 'package:http/testing.dart' as httpMock;
import 'package:http/http.dart' as http;
import 'package:mobile/globals.dart';
import 'package:mobile/src/Exceptions.dart';
import 'package:mobile/src/Pages/QuizPage/Model/QuizModel.dart';
import 'package:mobile/src/Pages/QuizPage/Model/AnswerPageModel.dart';
import 'package:momentum/momentum.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AnswerController extends MomentumController<AnswerPageModel> {
  AnswerController({this.mock = false});
  bool mock;

  @override
  AnswerPageModel init() {
    return AnswerPageModel(
      this,
      quiz_id: 0,
      lessonId: 0,
      answers: [],
    );
  }
}
