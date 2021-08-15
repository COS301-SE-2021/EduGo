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

/*------------------------------------------------------------------------------
 *                          Grades controller
 *------------------------------------------------------------------------------
 */

//Function to get the list of subjects from the database
Future<List<Subject>> getGrades({required http.Client client}) async {
  final response = await client.post(
    Uri.parse("${baseUrl}lesson/getStudentGrades"),
    headers: <String, String>{
      'Content-Type': 'application/json',
      "Authorization":
          "Bearer eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoxLCJpYXQiOjE2Mjg1MzUwMzgsImV4cCI6MTYyODYyMTQzOH0.rikKnXXsIuIy_pIfJcu1MRBh5eX6l85PR7rCg7GpiuKkBMv8ehLec1K_xFWtszr58M7pMMkcPVol_HvV6KULJ4QcyTMLcbPSmc5zGW59idsqBorYhoY35qyjLMK7IhgGeywDear3jGIiqdf4sv8JAs1onLBhQm_2IyiWa2OVFHXZ0v-Cwd-LtqgQyvyZKBwW_i8bqCmCGlBZCtMSCo61ci4HTJZXlQffey7YB796oVpm7Ibftlb1grPFbDdmt1vNYiirtoKv9gI69AY0H-w9PnaT34GzZ2748lSfTugo0TquHKxbvFgC0vJ_M7M4m-_P7S4pzu6j4uxLSqWslwU1ErMCgIK6fk9jfUnG8lVwEu5uVumf3_mKsj0NWE8bn9GrSOnXCAVlxrKqi_kNaeuKRKtLB0kwlQceoMVbCM_RcW_PacXlLDMN0CQMiGHvRyUhU8_A8p0wiTehPgQdhbQN60d0jYCl2sgXl5EkgFcxF3TYKWFJoOWqnKlVGOp42e-84soyV8Z7f0UMzLJWSun8XRu2pa3c6umKmauN3dSzKVEIOZUFGXER4LyZYTvjebn5nA4kf7PS1fPS4TszXmYk6-MCDBNO544ma5iNLQzJ_fCA4OffhCp7VK_JoKSaBAEvw-MnDGST-ITtOO-u5BH8ftdnIM9Mm0Ccdh9PMUXe1h0",
    },
  );

  //If there is a list of subjects that is returned,
  //convert it to a json object, else throw an exception
  if (response.statusCode == 200) {
    Map<String, dynamic> json = jsonDecode(response.body);
    if (json['data'] != null) {
      print('Data');
      print(json['data']);
      List<Subject> subjects =
          (json['data'] as List).map((e) => Subject.fromJson(e)).toList();
      print('Length Grades: ${subjects.length}');
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

  @override
  Future<void> bootstrapAsync() {
    print('Mock');
    print(mock);
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
