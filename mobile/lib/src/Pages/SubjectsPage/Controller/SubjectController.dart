/**
 * This is the subject controller. It handles the api calls for the subjects.
 * The endpoint is getSubjectsByUser which return a list of subjects.
 * That list is converted from a string to a json object. 
*/

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart' as httpMock;
import 'package:mobile/mockApi.dart' as mockApi;
import 'package:mobile/globals.dart';
import 'package:mobile/src/Exceptions.dart';
import 'package:mobile/src/Pages/SubjectsPage/Models/Subject.dart';
import 'package:mobile/src/Pages/SubjectsPage/Models/SubjectsModel.dart';
import 'package:momentum/momentum.dart';
//UNCOMMENT THIS IMPORT WHEN MERGED INTO DEVELOP-MOBILE-APP-COMBINED
//import 'package:shared_preferences/shared_preferences.dart';

/*------------------------------------------------------------------------------
 *                          Subject controller
 *------------------------------------------------------------------------------
 */

//Function to get the list of subjects from the database
Future<List<Subject>> getSubjectsByUser({required http.Client client}) async {
  //UNCOMMENT THESE 3 COMMENTS WHEN MERGED INTO DEVELOP-MOBILE-APP-COMBINED
  // final prefs = await SharedPreferences.getInstance();
  // final String? token = prefs.getString('user_token') ?? null;

  // if (token == null) throw NoToken();
  final response = await client.post(
    Uri.parse("${baseUrl}subject/getSubjectsByUser"),
    headers: <String, String>{
      "Content-Type": "application/json",
      "Authorization":
          "Bearer eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjo4LCJpYXQiOjE2Mjk3ODc2NTQsImV4cCI6MTYyOTg3NDA1NH0.XeB_Zt4vcP_gv0wm0Yd6Ho3irrwSyusF3W1_AVjbq1sgXRD7JpLi8QRJ3aVjOpqExB2Y-bYCVLBUHem0R4kUb_7WiUC9crx51vx60jPFFCSMgHjDo2LQwfV-Icw4_121N3_Xk0ieaL63nmqhztWR8GdNga2kfxBb0VI46HvIWO_LihP6YZbW5dovkCMwMInxVWL0LE1xPVNPEDKeQ62O70AsyLzPF0dx4JSbgxjzphJTJPNJiLtdJB0Ap3UgOk7oIgBvWSnwUK740nLD7BLPZIQRgjWdsODK598cNlzoANxorkx1iMqaDDG2pidTGLenaESlC8OvDswc6saK2--JZ-hWkSq6zPx54KtK4j__bZA8ZcRb5_-Q1_7e59PvS4N64LK6d1YG5Mpjr0yCAu8x-yljkcQe74D0MyPctDJeXrONDDGhp6nuzXI5RRGUQWwjNOpuuUxEPOkMK_e8GbZUnATl-OIyW5hlhnf-4Kt2BVWlAChsQyFfRjRU39Hv86ESOsDcDGFyaEJRmWnUKqMPga0YIuxGXEYMQeLrnaYrNk1NkDHS18w6RE8UPuj6YG03td10FPR8TDkNBmPsB69tWVNq38fGNBgfDjmKyNBB6JXfWnBTnTKyAtx-K0Y3fO1Fqa5TRe73Qmm8paYuL1ygVt-RhLXZo8W_EKuphQM0lm8",
    },
  );

  //If there is a list of subjects that is returned,
  //convert it to a json object, else throw an exception
  if (response.statusCode == 200) {
    Map<String, dynamic> json = jsonDecode(response.body);
    if (json['data'] != null) {
      List<Subject> subjects =
          (json['data'] as List).map((e) => Subject.fromJson(e)).toList();
      return subjects;
    } else
      throw new BadResponse('No data property');
  }
  throw new Exception('Not a code 200');
}

//SubjectsController constructor with a default value of mock set to false
class SubjectsController extends MomentumController<SubjectsModel> {
  SubjectsController({this.mock = false});

  //Used to determine if mock data should be used
  //or real data from the api call
  bool mock;

  //Initialize the subjects to an empty array in the beginning
  @override
  SubjectsModel init() {
    return SubjectsModel(this, subjects: []);
  }

  //Bootstrap function is run immediately/automatically when page is opened

  Future<void> getSubjects() {
    return getSubjectsByUser(
            //If bool is set to true in the controller constructor in the main file,
            //it uses mock the actual api end point
            //If bool is set to true in the controller constructor in the main file,
            //it uses mock data
            client: mock
                ? httpMock.MockClient(mockApi.getSubjectsByUserClient)
                : http.Client())
        .then((value) {
      model.update(subjects: value);
    });
  }
}
