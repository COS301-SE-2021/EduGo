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
import 'package:shared_preferences/shared_preferences.dart';

/*------------------------------------------------------------------------------
 *                          Subject controller
 *------------------------------------------------------------------------------
 */

//Function to get the list of subjects from the database
Future<List<Subject>> getSubjectsByUser({required http.Client client}) async {
  final prefs = await SharedPreferences.getInstance();
  final String? token = prefs.getString('user_token') ?? null;
  // print('--- TOKEN ---');
  // print(token);

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
      // print(json['data']);
      List<Subject> subjects =
          (json['data'] as List).map((e) => Subject.fromJson(e)).toList();
      // print("Length: ${subjects.length}");
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
  @override
  Future<void> bootstrapAsync() {
    return getSubjectsByUser(
            //If bool is set to true in the controller constructor in the main file,
            //it uses mock the actual api end point
            //If bool is set to true in the controller constructor in the main file,
            //it uses mock data
            client: mock
                ? httpMock.MockClient(mockApi.getSubjectsByUserClient)
                : http.Client())
        .then((value) {
      //print('Value');
      //print(value);
      model.update(subjects: value);
    });
  }
}
