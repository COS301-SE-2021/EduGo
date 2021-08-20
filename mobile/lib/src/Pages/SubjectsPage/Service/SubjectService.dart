import 'dart:convert';

import 'package:mobile/src/Exceptions.dart';
import 'package:mobile/src/Pages/SubjectsPage/Models/Subject.dart';
import 'package:momentum/momentum.dart';
import 'package:http/http.dart' as http;
import 'package:mobile/globals.dart';
import 'package:shared_preferences/shared_preferences.dart';


class SubjectService extends MomentumService {
  //Function to get the list of subjects from the database
  Future<List<Subject>> getSubjectsByUser({required http.Client client}) async {
    final prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('user_token') ?? null;

    if (token == null) throw NoToken();

    final response = await client.post(
        Uri.parse("${baseUrl}subject/getSubjectsByUser"),
        headers: <String, String>{
          "Content-Type": "application/json",
          "Authorization": token,
        });

    //If there is a list of subjects that is returned,
    //convert it to a json object, else throw an exception
    if (response.statusCode == 200) {
      Map<String, dynamic> json = jsonDecode(response.body);
      if (json['data'] != null) {
        List<Subject> subjects = (json['data'] as List).map((e) => Subject.fromJson(e)).toList();
        return subjects;
      } else throw new BadResponse('No data property');
    }
    throw new Exception('Not a code 200');
  }
}