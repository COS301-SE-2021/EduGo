/**
   * This widget will be a stateless widget and is responsible for displaying the 
   * subjects as cards. There will be a title, grade and subject image that can be passed 
   * into the constructor when displaying the subjects
   */
import 'package:flutter/material.dart';
import 'package:mobile/src/Pages/LessonsPage/View/LessonInformationPage.dart';

class LessonsCard extends StatelessWidget {
  final String lessonTitle;
  final int lessonID;
  final String lessonDescription;
  //This holds the start time of the lesson
  final String lessonStartTime;
  //This holds the end time of the lesson
  final String lessonEndTime;

  //final *type* subjectImage

  LessonsCard(
      {required this.lessonTitle,
      required this.lessonID,
      required this.lessonDescription,
      required this.lessonStartTime,
      required this.lessonEndTime});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      width: 250,

      child: Card(
        semanticContainer: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        clipBehavior: Clip.antiAlias,
        color: Colors.black,
        //This allows the card to be clickable so that when clicked,
        // it will go to the lessons for that subject
        child: new InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => LessonInformationPage()),
            );
          },
          child: Container(
            child: Align(
              alignment: Alignment.center,
              child: Text(
                "$lessonTitle",
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                maxLines: 3,
                softWrap: false,
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
          ),
        ),
      ),

      //),
    );
  }
}
