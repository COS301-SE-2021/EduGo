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
import 'package:shared_preferences/shared_preferences.dart';

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
  final prefs = await SharedPreferences.getInstance();
  final String? token = prefs.getString('user_token') ?? null;

  if (token == null) throw NoToken();
  final response =
      await client.post(Uri.parse("${baseUrl}lesson/getLessonsBySubject"),
          headers: <String, String>{
            'Content-Type': 'application/json',
            "Authorization": token,
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
    return LessonsModel(this, lessons: [], id: 0, title: '');
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

  void updateLesson(context, int id, String title) {
    model.update(
      lessons: model.lessons,
      id: id,
      title: title,
    );
    buildLessonInfoView();
    MomentumRouter.goto(context, LessonInformationPage);
  }

  void buildLessonInfoView() {
    //display everything in model on screen

    /*model.lessonVirtualEntities.forEach(
      (ve) {
        VECards.add(
          new VECards(
            //id
            //thumbnail image
          ),
        );
      },
    );*/
    model.update(
      view: Row(
        children: [
          Text('view here'),
        ],
      ),
    );
  }
}
