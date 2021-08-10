/**
   * This widget will be a stateless widget and is responsible for displaying the 
   * subjects as cards. There will be a title, grade and subject image that can be passed 
   * into the constructor when displaying the subjects
   */
import 'package:flutter/material.dart';
import 'package:mobile/src/Pages/LessonsPage/View/LessonInformationPage.dart';

class LessonsCard extends StatelessWidget {
  //Holds the lesson title
  final String lessonTitle;

  //Holds the lessonid
  final int lessonID;

  //Holds the lesson description
  final String lessonDescription;

  //Holds the lesson objectives
  //final String lessonObjectives

//LessonCardConstructor. Takes in 4 arguments
  LessonsCard({
    required this.lessonTitle,
    required this.lessonID,
    required this.lessonDescription,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      width: 250,
      //This is the main lesson card design. It is all in a container and
      //displays info like the lesson title, lesson objectives and
      //the lesson
      child: Card(
        semanticContainer: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        clipBehavior: Clip.antiAlias,
        color: Colors.black,
        //This allows the card to be clickable so that when clicked,
        // it will go to the lessons description for that lesson
        child: new InkWell(
          //This redirects the page to the lessons description page on tap
          //and passes in the lesson description, lesson objectives and lesson title
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => LessonInformationPage(
                  lessonTitle: this.lessonTitle,
                  lessonDescription: this.lessonDescription,
                  lessonID: this.lessonID,
                ),
              ),
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
