import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http/testing.dart' as httpMock;
import 'package:mobile/mockApi.dart' as mockApi;
import 'package:mobile/globals.dart';
import 'package:mobile/src/Exceptions.dart';
import 'package:mobile/src/Pages/SubjectsPage/Models/Subject.dart';
import 'package:mobile/src/Pages/SubjectsPage/Models/SubjectsModel.dart';
import 'package:momentum/momentum.dart';

Future<List<Subject>> getSubjectsByUser(int userId, {required http.Client client}) async {
  final response = await client.post(
    Uri.parse("${baseUrl}subject/getSubjectsByUser"),
    headers: <String, String>{
      "Content-Type": "application/json",
    },
    body: jsonEncode(<String, int>{'user_id': userId})
  );

  if (response.statusCode == 200) {
    Map<String, dynamic> json = jsonDecode(response.body);
    if (json['data'] != null) {
      List<Subject> subjects = (json['data'] as List).map((e) => Subject.fromJson(e)).toList();
      return subjects;
    }
    else throw new BadResponse('No data property');
  }
  throw new Exception('Not a code 200');
}

class SubjectsController extends MomentumController<SubjectsModel> {
  SubjectsController({this.mock = false});

  bool mock;

  @override
  SubjectsModel init() {
    return SubjectsModel(this, subjects: []);
  }

  @override
  Future<void> bootstrapAsync() {
    return getSubjectsByUser(1, client: mock ? httpMock.MockClient(mockApi.getSubjectsByUserClient) : http.Client()).then((value) {
      model.update(subjects: value);
    });
  }

}