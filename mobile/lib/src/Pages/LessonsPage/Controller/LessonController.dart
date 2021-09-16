/**
 * This is the lesson controller. It handles the api calls for the lessons.
 * The endpoint is getLessonsBySubject which return a list of lessons.
 * That list is converted from a string to a json object. 
*/

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mobile/src/Components/LessonsCardWidgets.dart';
import 'package:mobile/src/Exceptions.dart';
import 'package:mobile/src/Pages/LessonsPage/Controller/LessonInformationController.dart';
import 'package:mobile/src/Pages/LessonsPage/Models/Lesson.dart';
import 'package:mobile/mockApi.dart' as mockApi;
import 'package:http/http.dart' as http;
import 'package:http/testing.dart' as httpMock;
import 'package:mobile/globals.dart';
import 'package:mobile/src/Pages/LessonsPage/Models/LessonsModel.dart';
import 'package:mobile/src/Pages/LessonsPage/View/LessonInformationPage.dart';
import 'package:mobile/src/Pages/LessonsPage/View/LessonsPage.dart';
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
    return LessonsModel(
      this,
      lessons: [],
      id: 0,
      title: '',
      view: Row(
        children: [
          Text('No lesson(s)'),
        ],
      ),
    );
  }

  Future<void> getLessons(context, int subjectId, String subjectTitle) {
    return getLessonsBySubject(subjectId,
            //If bool is set to true in the controller constructor in the main file,
            //it uses mock the actual api end point
            //If bool is set to true in the controller constructor in the main file,
            //it uses mock data
            client: mock
                ? httpMock.MockClient(mockApi.getLessonsBySubjectClient)
                : http.Client())
        .then((value) {
      model.update(lessons: value);
      int lessonsCount = model.lessons.length;

      // A check to see if there are subjects. If there are no subjects,
      // display another card saying no subjects are available
      Widget view;

      if (lessonsCount > 0 && model.lessons.isNotEmpty) {
        view = Container(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Align(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 25),
                    child: Text(
                      subjectTitle,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      softWrap: false,
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                  ),
                ),
                Align(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 25),
                    child: Text(
                      '$lessonsCount' + ' lessons',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      softWrap: false,
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                  ),
                ),
                GridView.count(
                  //This makes 2 cards appear. So effectively two cards
                  //per page. (2 rows, 1 card per row)
                  childAspectRatio: MediaQuery.of(context).size.height / 100,
                  primary: false,
                  padding: const EdgeInsets.all(20),
                  crossAxisSpacing: 0,
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  mainAxisSpacing: 10,
                  //makes 1 cards per row
                  crossAxisCount: 1,
                  children: model.lessons
                      .map((lesson) => LessonsCard(
                          lessonVirtualEntity: lesson.virtualEntities,
                          lessonTitle: lesson.title,
                          lessonID: lesson.id,
                          lessonDescription: lesson.description,
                          lessonCompleted: lesson.lessonCompleted))
                      .toList(),
                ),
              ],
            ),
          ),
        );
      }
      //Display a spinner card if no mark for lessons
      //or between api calls
      else
        view = SpinKitCircle(
          color: Colors.black,
        );

      model.update(
        lessons: model.lessons,
        id: subjectId,
        title: subjectTitle,
        view: view,
      );
      MomentumRouter.goto(context, LessonsPage);
    });
  }

  void updateLesson(context, int subjectId, String subjectTitle) {
    //API call to get all lesson details of this specific subject
    getLessons(context, subjectId, subjectTitle);

    //gotoLessonInfoPage(context, subjectId);
  }

  //use for cleaner code if i want
  void setView() {}
  Widget getView() {
    return model.view;
  }

  void gotoLessonInfoPage(context, id) {
    // display information for specific lesson
    Momentum.controller<LessonInformationController>(context)
        .updateLessonInformation(
      context,
      '',
      '',
      0,
      [],
    );
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
