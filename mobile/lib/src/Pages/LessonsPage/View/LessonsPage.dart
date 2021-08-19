/**
 * This is the lesson page. It follows the mvc design pattern 
 * and is implemented using Momentum. The lessonCard widget 
 * is used to display the lesson cards. The lessonController is 
 * passed into the MomentumBuilder widget and handles the api call 
 * to get the data and also handles the conversion from string to json 
 */

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mobile/src/Components/ErrorHandelingCard.dart';
import 'package:mobile/src/Components/LessonsCardWidgets.dart';
import 'package:mobile/src/Components/mobile_page_layout.dart';
import 'package:mobile/src/Pages/LessonsPage/Controller/LessonController.dart';
import 'package:mobile/src/Pages/LessonsPage/Models/LessonsModel.dart';
import 'package:momentum/momentum.dart';

/*------------------------------------------------------------------------------
 *                          Lesson View Page  
 *------------------------------------------------------------------------------
 */
class LessonsPage extends StatefulWidget {
  //This title variable holds the subject
  //title of the card that was clicked on
  final String title;

  //This subject ID variable holds the subject
  //id of the card that was clicked on
  final int subjectID;

  //LessonPage constructor
  LessonsPage({Key? key, required this.title, required this.subjectID})
      : super(key: key);

  @override
  _LessonsPageState createState() =>
      _LessonsPageState(title: this.title, subjectID: this.subjectID);
}

class _LessonsPageState extends State<LessonsPage> {
  String title;
  int subjectID;

  _LessonsPageState({required this.subjectID, required this.title});

  @override
  Widget build(BuildContext context) {
    //mobilepagelayout takes 3 arguments. 2 bools and a momentumbuilder.
    //the two bool represent side bar and navbar. so if true and true, them
    //the side bar and nav bar will be displayed.
    //i.e true=yes display, false=no do not display
    return MobilePageLayout(
      false,
      true,
      //Container(
      MomentumBuilder(
        controllers: [LessonsController],
        builder: (context, snapshot) {
          //Used by momentum mvc model
          //Used to get the list of lessons
          final lessons = snapshot<LessonsModel>();

          //Used to call the specific function in the controller called getLessons
          //This requires the subjectID to be passed
          final lessonController =
              Momentum.controller<LessonsController>(context);

          //Call the getLessonsfunction to pass in the subject id.
          //This is needed to map the lessons to the subjects in the controller
          lessonController.getLessons(subjectID);

          //Get the number of lessons for a particular subject
          int lessonsCount = lessons.lessons.length;

          //A check to see if there are subjects. If there are no subjects,
          //display another card saying no subjects are available
          if (lessonsCount > 0 && lessons.lessons.isNotEmpty) {
            return Container(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Align(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 25),
                        child: Text(
                          title,
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
                      childAspectRatio:
                          MediaQuery.of(context).size.height / 180,
                      primary: false,
                      padding: const EdgeInsets.all(20),
                      crossAxisSpacing: 0,
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      mainAxisSpacing: 10,
                      //makes 1 cards per row
                      crossAxisCount: 1,
                      children: lessons.lessons
                          .map(
                            (lesson) => LessonsCard(
                              lessonTitle: lesson.title,
                              lessonID: lesson.id,
                              lessonDescription: lesson.description,
                              lessonCompleted: lesson.lessonCompleted,
                            ),
                          )
                          .toList(),
                    ),
                  ],
                ),
              ),
            );
          }
          //If there are no lessons
          else
            // return ErrorCard(
            //   errorDescription:
            //       "There are currently no lessons to be displayed",
            // );
            return SpinKitCircle(
              color: Colors.black,
            );
        },
      ),
      'Lessons',
    );
  }
}
