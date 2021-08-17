import 'dart:convert';
import 'package:mobile/mockApi.dart' as mockApi;
import 'package:http/testing.dart' as httpMock;
import 'package:http/http.dart' as http;
import 'package:mobile/globals.dart' as globals;
import 'package:mobile/src/Exceptions.dart';
import 'package:mobile/src/Pages/QuizPage/Model/QuizModel.dart';
import 'package:mobile/src/Pages/QuizPage/Model/QuizPageModel.dart';
import 'package:momentum/momentum.dart';

Future<List<Quiz>> getQuizesByLesson(int id,
    {required http.Client client}) async {
  final response = await client.post(
      Uri.parse("${globals.baseUrl}virtualEntity/getQuizesByLesson"),
      headers: <String, String>{
        'Content-Type': 'application/json',
        //'Authorization': token
      },
      body: jsonEncode(<String, int>{'id': id}));

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

class QuizController extends MomentumController<QuizPageModel> {
  QuizController({this.mock = false});
  bool mock;

  QuizPageModel init() {
    return QuizPageModel(this, quizes: []);
  }

  @override
  Future<void> bootstrapAsync() {
    return getQuizesByLesson(1,
            client: mock
                ? httpMock.MockClient(mockApi.getQuizesByLesson)
                : http.Client())
        .then((value) {
      print('Value');
      print(value);
      model.update();
    });
  }
}
