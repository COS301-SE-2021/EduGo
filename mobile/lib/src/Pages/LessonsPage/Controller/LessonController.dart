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
                "Bearer eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjo4LCJpYXQiOjE2MjkyODUxNzgsImV4cCI6MTYyOTM3MTU3OH0.nUHp27qXDN2jCpk14YqL1X4BSgHmgrlKQOE1UdkO0FfvU0KZFmOEHKycOXnfzQYTNoBMIJkbKbwbbSnBp1h1zALaKwR8xIM7gWnZ2eW59ZXy741leCWbaH7Fy2JH-lJeT8GAS46DRPZIoddD6s_DXuoFKWYyK_QXJJC_QotuRQWGUH80vz293XvYpm8U7stoOMcjbWCLRJy5c4QyS-cgSGq4b4BpEITFKo4W4A5dqlnDLwRkEVuFzhkPnhnEWTWvfp1SS1YzNhjwv5ObfbuIrrDZ1JvOIkc6_SceFcz40K-JcZX95l8K1YCPs6FtArYA-ZEp8rsLM89zmnl-JiG2hMK-3JyHvmsgSor54LWvDBOpfHYWbFaXY7A2fGFSpJd_BRgxH3NEDqfxa2QVsvXBDYIJu5ELBy3J5DyO9gOAVvgM6nTyMYkPrpmopkhCefYvmT-rR9JXY33ltFd5X3SvBV99SFv69UJ3lUOgjaoQZLT9UC5yOXCIsFTw-IGMv3X5KPU_PIww0f3PimiwXKI0_g-gi-n_sxcVIu6Dia2SKlVSqwDHRazoKx6h61VHIbZkiLD3yQ56T4HeRLohxr6mWyYxK_vl-CHMkx7DMNPvQ9n8BiEZ2uYPhkmh-hdRuajDqobE8JPW0bHdiAwyiMj6xQrPLIQV6dd4Tpd-pd00kXg",
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
