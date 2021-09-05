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
import 'package:mobile/src/Pages/SubjectsPage/Service/SubjectService.dart';
import 'package:momentum/momentum.dart';
import 'package:shared_preferences/shared_preferences.dart';

/*------------------------------------------------------------------------------
 *                          Subject controller
 *------------------------------------------------------------------------------
 */



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
    final api = service<SubjectService>();
    return api.getSubjectsByUser(
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

  Future<void> refreshAsync() {
    final api = service<SubjectService>();
    return api.getSubjectsByUser(
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
