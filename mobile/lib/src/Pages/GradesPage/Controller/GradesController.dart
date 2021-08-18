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
//UNCOMMENT THIS IMPORT WHEN MERGED INTO DEVELOP-MOBILE-APP-COMBINED
//import 'package:shared_preferences/shared_preferences.dart';

/*------------------------------------------------------------------------------
 *                          Grades controller
 *------------------------------------------------------------------------------
 */

//Function to get the list of subjects from the database
Future<List<Subject>> getGrades({required http.Client client}) async {
  //UNCOMMENT THESE 3 COMMENTS WHEN MERGED INTO DEVELOP-MOBILE-APP-COMBINED
  // final prefs = await SharedPreferences.getInstance();
  // final String? token = prefs.getString('user_token') ?? null;

  // if (token == null) throw NoToken();
  final response = await client.get(
    Uri.parse("${baseUrl}user/getStudentGrades"),
    headers: <String, String>{
      'Content-Type': 'application/json',
      "Authorization":
          "Bearer eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjo4LCJpYXQiOjE2MjkyODY2NjMsImV4cCI6MTYyOTM3MzA2M30.KYzzZbqk6_HpW-_mdqf2p1LlWjzsOTVplx4Vi850KHNJDXAiSmBR-R8L85liOB-ijpOXFVqMa2zz63SBd-gx06kdBdms48Ah9oFVoOvOziSDuhSUKK-GmuV6GhBKr5rhoAoPbSS600AXjFuJCYSjdqitaVDPp5Be4JJjQUXzm_D-T7QoxhvJMyd5NESCGIT4Pv8OT-7ph90z1nGmSUNVLjV1FTBNHRcxnrKZDm4r8_iGwjBoTxcE5slXlh8xvNwJsWT3U3c-8mtnApRappfL5bE44gjmq0t2gxx6S4RkcipUYlC_cbzKwk10ITVQAcX9pEcNmoQAeE1ZYIemkyLS9I3sHVRffJoSOjJo5tHd0ZeTWCaLsdafBfSSjDvZr2jYtSky1ejDf_qpNjdS-_zbe-5i6wSA_3RedqHNyOHZMGmkgBjlgCwWkv6zGq-KifEcC18319CnPOW3H4SPrjugcbGFcP4NZ-cXnil3a-0GUtkgyYWI8O8n_NxEpggt-lc8Ge80vbSB4E-1jMkvSVDZSBcQgeIX5Jn5H2so1Yjoaz7ZO2QZn15EYwg6rgq35DYOH39OZI4IS8WOJksvBWz09OceiGJbppCJHX_Vlhhdd8cSY-hL-F2izT1ljjRSuHDTFKKc805AwG1YM5dzIjTA1W1T0vwqPuBss3L_EJzjxZk",

      //UNCOMMENT THIS WHEN MERGED INTO DEVELOP-APP-MOBILE-COMBINED
      //"Authorization": token
    },
  );

  //If there is a list of subjects that is returned,
  //convert it to a json object, else throw an exception
  print(response.statusCode);

  // json.toString(response);

  print(response.body);
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

  @override
  Future<void> bootstrapAsync() {
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
