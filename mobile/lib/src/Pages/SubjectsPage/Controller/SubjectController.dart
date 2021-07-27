import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mobile/globals.dart';
import 'package:mobile/src/Exceptions.dart';
import 'package:mobile/src/Pages/SubjectsPage/Models/SubjectModels.dart';

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