/**
 * This is the grades controller. It handles the api calls for the grades.
 * The endpoint is getStudentGrades which return a list of subjects.
 * A subject in the list has an id, a title, a subject mark and a list of
 * lessons. A lesson in the list has an id, a title a lesson mark and a 
 * list of quizzes. A quiz in the list has an id, a student mark for the 
 * quiz, a quiz overall mark and a quiz title.
 * That list is converted from a string to a json object. 
 */

import 'dart:convert';
import 'package:mobile/src/Exceptions.dart';
import 'package:mobile/src/Pages/GradesPage/Model/Grades.dart';
import 'package:mobile/src/Pages/GradesPage/Model/GradesModel.dart';
import 'package:mobile/mockApi.dart' as mockApi;
import 'package:http/http.dart' as http;
import 'package:http/testing.dart' as httpMock;
import 'package:mobile/globals.dart';
import 'package:momentum/momentum.dart';
import 'package:shared_preferences/shared_preferences.dart';

/*------------------------------------------------------------------------------
 *                          Grades controller
 *------------------------------------------------------------------------------
 */

//Function to get the list of subjects from the database
Future<List<Subject>> getGrades({required http.Client client}) async {
  final prefs = await SharedPreferences.getInstance();
  final String? token = prefs.getString('user_token') ?? null;


  if (token == null) throw NoToken();
  final response = await client.get(
    Uri.parse("${baseUrl}user/getStudentGrades"),
    headers: <String, String>{
      'Content-Type': 'application/json',
      "Authorization": token
    },
  );

  //If there is a list of subjects that is returned,
  //convert it to a json object, else throw an exception
  if (response.statusCode == 200) {
    Map<String, dynamic> json = jsonDecode(response.body);
    if (json['subjects'] != null) {
      List<Subject> subjects =
          (json['subjects'] as List).map((e) => Subject.fromJson(e)).toList();
      return subjects;
    } else
      throw new BadResponse('No data property');
  }
  throw Exception('Not a code 200');
}

//Gradescontroller constructor with a default value of mock set to false
class GradesController extends MomentumController<GradesModel> {
  GradesController({this.mock = false});

  //Used to determine if mock data should be used
  //or real data from the api call
  bool mock;

  @override
  GradesModel init() {
    return GradesModel(this, subjects: []);
  }

  //Used in the GradesSubjectPage to get the grades onload every time instead
  //of at the start of app(not using bootstrapasync function)
  Future<void> getGradesOnload() {
    return getGrades(
            //If bool is set to true in the controller constructor in the main file,
            //it uses mock the actual api end point
            //If bool is set to true in the controller constructor in the main file,
            //it uses mock data
            client: mock
                ? httpMock.MockClient(mockApi.getGradesByUserClient)
                : http.Client())
        .then((value) {
      model.update(subjects: value);
    });
  }
}
