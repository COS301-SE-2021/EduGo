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

/*------------------------------------------------------------------------------
 *                          Subject controller
 *------------------------------------------------------------------------------
 */

//Function to get the list of subjects from the database
Future<List<Subject>> getSubjectsByUser(int userId,
    {required http.Client client}) async {
  final response =
      await client.post(Uri.parse("${baseUrl}subject/getSubjectsByUser"),
          headers: <String, String>{
            "Content-Type": "application/json",
            "Authorization":
                "Bearer eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoxLCJpYXQiOjE2Mjg1OTY2MzAsImV4cCI6MTYyODY4MzAzMH0.rTVtPvjf6BvurpOip2DSRjQ-x5t5AnXsOqB8sBbZVws4X04IlG-GH3uFIXMZiH08HFPSSmM16q-x9tmFkr1k1a8yNuv6QHtBK3j69DuAZJae5JTEBOp2q3vmMUS7hB7tOkm_HIPEKg2dk7JCiaM-WuNg_LkDIHT6M_NXGHrI1T8IKi7y9lrbYs173GpahgnWzDdUPoBwTnFf79fiMoobOCbHdCSk58P0U-srWfDqzYaiuNpTEoV3diLqJ-w7MElFJ9PfGDLR1i5yun81zstT7lXqxyRhMQpdfP-pt-BW0tBs8MrNTz_2ZQ1yNfk9z-KnV_6i_Dk64tsA89TOXUzFlshtVexzLj7fz0me14FrRIoqDwNplxnMdhTVWlQBMm_B_Y9Nini2NBBJdQqsq8zObCfdzCsTtYTDkRZr3en2pws5P4Zyy3yrKNxamG2Z3lGVVL8Kx5nEqvUA9Oq3KMnw7wpajj1GWqi-PSWkKeANUtia6wl8qdmAiBDtD8M7eWsdwrMktI1xOSJu2MufJQ9o6hq1D3nr5k-IEfYaylDSvXrh-v8xGab0SJZOyq20lIHMXi2r_PLDr6erwYeq75j49mqbX1vpZSqvW5ByBUgdhYMVdcYRueRUWpA1Qih1vyVXWJSiZoIWk0RDxh3jvH_g9EysmZjKzSy0d51gwJtymjE",
          },
          body: jsonEncode(<String, int>{'user_id': userId}));

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
  @override
  Future<void> bootstrapAsync() {
    return getSubjectsByUser(100,
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
