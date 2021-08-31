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

//UNCOMMENT THIS IMPORT WHEN MERGED INTO DEVELOP-MOBILE-APP-COMBINED
//USED FOR SHARED PREFERENCES
//import 'package:shared_preferences/shared_preferences.dart';

/*------------------------------------------------------------------------------
 *                          Lesson controller
 *------------------------------------------------------------------------------
*/

//Function to get the list of lessons from the database
Future<List<Lesson>> getLessonsBySubject(int subject_id,
    {required http.Client client}) async {
  //UNCOMMENT THESE 3 COMMENTS WHEN MERGED INTO DEVELOP-MOBILE-APP-COMBINED
  // final prefs = await SharedPreferences.getInstance();
  // final String? token = prefs.getString('user_token') ?? null;

  // if (token == null) throw NoToken();
  final response =
      await client.post(Uri.parse("${baseUrl}lesson/getLessonsBySubject"),
          headers: <String, String>{
            'Content-Type': 'application/json',
            "Authorization":
                "Bearer eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjo4LCJpYXQiOjE2Mjk3ODc2NTQsImV4cCI6MTYyOTg3NDA1NH0.XeB_Zt4vcP_gv0wm0Yd6Ho3irrwSyusF3W1_AVjbq1sgXRD7JpLi8QRJ3aVjOpqExB2Y-bYCVLBUHem0R4kUb_7WiUC9crx51vx60jPFFCSMgHjDo2LQwfV-Icw4_121N3_Xk0ieaL63nmqhztWR8GdNga2kfxBb0VI46HvIWO_LihP6YZbW5dovkCMwMInxVWL0LE1xPVNPEDKeQ62O70AsyLzPF0dx4JSbgxjzphJTJPNJiLtdJB0Ap3UgOk7oIgBvWSnwUK740nLD7BLPZIQRgjWdsODK598cNlzoANxorkx1iMqaDDG2pidTGLenaESlC8OvDswc6saK2--JZ-hWkSq6zPx54KtK4j__bZA8ZcRb5_-Q1_7e59PvS4N64LK6d1YG5Mpjr0yCAu8x-yljkcQe74D0MyPctDJeXrONDDGhp6nuzXI5RRGUQWwjNOpuuUxEPOkMK_e8GbZUnATl-OIyW5hlhnf-4Kt2BVWlAChsQyFfRjRU39Hv86ESOsDcDGFyaEJRmWnUKqMPga0YIuxGXEYMQeLrnaYrNk1NkDHS18w6RE8UPuj6YG03td10FPR8TDkNBmPsB69tWVNq38fGNBgfDjmKyNBB6JXfWnBTnTKyAtx-K0Y3fO1Fqa5TRe73Qmm8paYuL1ygVt-RhLXZo8W_EKuphQM0lm8",
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
