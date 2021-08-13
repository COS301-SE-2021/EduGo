/**
 * This is the lesson controller. It handles the api calls for the lessons.
 * The endpoint is getLessonsBySubject which return a list of lessons.
 * That list is converted from a string to a json object. 
*/

import 'dart:convert';
import 'package:mobile/src/Exceptions.dart';
import 'package:mobile/src/Pages/LessonsPage/Models/Lesson.dart';
import 'package:mobile/mockApi.dart' as mockApi;
import 'package:http/http.dart' as http;
import 'package:http/testing.dart' as httpMock;
import 'package:mobile/globals.dart';
import 'package:mobile/src/Pages/LessonsPage/Models/LessonsModel.dart';
import 'package:momentum/momentum.dart';

/*------------------------------------------------------------------------------
 *                          Lesson controller
 *------------------------------------------------------------------------------
*/

//Function to get the list of lessons from the database
Future<List<Lesson>> getLessonsBySubject(int subject_id,
    {required http.Client client}) async {
  final response =
      await client.post(Uri.parse("${baseUrl}lesson/getLessonsBySubject"),
          headers: <String, String>{
            'Content-Type': 'application/json',
            "Authorization":
                "Bearer eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoxLCJpYXQiOjE2Mjg1MzUwMzgsImV4cCI6MTYyODYyMTQzOH0.rikKnXXsIuIy_pIfJcu1MRBh5eX6l85PR7rCg7GpiuKkBMv8ehLec1K_xFWtszr58M7pMMkcPVol_HvV6KULJ4QcyTMLcbPSmc5zGW59idsqBorYhoY35qyjLMK7IhgGeywDear3jGIiqdf4sv8JAs1onLBhQm_2IyiWa2OVFHXZ0v-Cwd-LtqgQyvyZKBwW_i8bqCmCGlBZCtMSCo61ci4HTJZXlQffey7YB796oVpm7Ibftlb1grPFbDdmt1vNYiirtoKv9gI69AY0H-w9PnaT34GzZ2748lSfTugo0TquHKxbvFgC0vJ_M7M4m-_P7S4pzu6j4uxLSqWslwU1ErMCgIK6fk9jfUnG8lVwEu5uVumf3_mKsj0NWE8bn9GrSOnXCAVlxrKqi_kNaeuKRKtLB0kwlQceoMVbCM_RcW_PacXlLDMN0CQMiGHvRyUhU8_A8p0wiTehPgQdhbQN60d0jYCl2sgXl5EkgFcxF3TYKWFJoOWqnKlVGOp42e-84soyV8Z7f0UMzLJWSun8XRu2pa3c6umKmauN3dSzKVEIOZUFGXER4LyZYTvjebn5nA4kf7PS1fPS4TszXmYk6-MCDBNO544ma5iNLQzJ_fCA4OffhCp7VK_JoKSaBAEvw-MnDGST-ITtOO-u5BH8ftdnIM9Mm0Ccdh9PMUXe1h0",
          },
          body: jsonEncode(<String, int>{'subjectId': subject_id}));

  //If there is a list of lessons that is returned,
  //convert it to a json object, else throw an exception
  if (response.statusCode == 200) {
    Map<String, dynamic> json = jsonDecode(response.body);
    if (json['data'] != null) {
      List<Lesson> lessons =
          (json['data'] as List).map((e) => Lesson.fromJson(e)).toList();
      return lessons;
    } else
      throw new BadResponse('No data property');
  }
  throw Exception('Not a code 200');
}

//LessonController constructor with a default value of mock set to false
class LessonsController extends MomentumController<LessonsModel> {
  LessonsController({this.mock = false});

  //Used to determine if mock data should be used
  //or real data from the api call
  bool mock;

  //Initialize the lessons to an empty array in the beginning
  @override
  LessonsModel init() {
    return LessonsModel(this, lessons: []);
  }

  Future<void> getLessons(int subjectID) {
    return getLessonsBySubject(subjectID,
            //If bool is set to true in the controller constructor in the main file,
            //it uses mock the actual api end point
            //If bool is set to true in the controller constructor in the main file,
            //it uses mock data
            client: mock
                ? httpMock.MockClient(mockApi.getLessonsBySubjectClient)
                : http.Client())
        .then((value) {
      model.update(lessons: value);
    });
  }
}
