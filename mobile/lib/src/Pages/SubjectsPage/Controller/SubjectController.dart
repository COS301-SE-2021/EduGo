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
          "Bearer eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjo4LCJpYXQiOjE2MjkyODUxNzgsImV4cCI6MTYyOTM3MTU3OH0.nUHp27qXDN2jCpk14YqL1X4BSgHmgrlKQOE1UdkO0FfvU0KZFmOEHKycOXnfzQYTNoBMIJkbKbwbbSnBp1h1zALaKwR8xIM7gWnZ2eW59ZXy741leCWbaH7Fy2JH-lJeT8GAS46DRPZIoddD6s_DXuoFKWYyK_QXJJC_QotuRQWGUH80vz293XvYpm8U7stoOMcjbWCLRJy5c4QyS-cgSGq4b4BpEITFKo4W4A5dqlnDLwRkEVuFzhkPnhnEWTWvfp1SS1YzNhjwv5ObfbuIrrDZ1JvOIkc6_SceFcz40K-JcZX95l8K1YCPs6FtArYA-ZEp8rsLM89zmnl-JiG2hMK-3JyHvmsgSor54LWvDBOpfHYWbFaXY7A2fGFSpJd_BRgxH3NEDqfxa2QVsvXBDYIJu5ELBy3J5DyO9gOAVvgM6nTyMYkPrpmopkhCefYvmT-rR9JXY33ltFd5X3SvBV99SFv69UJ3lUOgjaoQZLT9UC5yOXCIsFTw-IGMv3X5KPU_PIww0f3PimiwXKI0_g-gi-n_sxcVIu6Dia2SKlVSqwDHRazoKx6h61VHIbZkiLD3yQ56T4HeRLohxr6mWyYxK_vl-CHMkx7DMNPvQ9n8BiEZ2uYPhkmh-hdRuajDqobE8JPW0bHdiAwyiMj6xQrPLIQV6dd4Tpd-pd00kXg",
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
      model.update(subjects: value);
    });
  }
}
