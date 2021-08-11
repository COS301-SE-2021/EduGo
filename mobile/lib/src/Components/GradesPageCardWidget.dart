/**
   * This widget will be a stateless widget and is responsible for displaying the 
   * grades as cards. There will be a subject and grade that can be passed 
   * into the constructor when displaying the subjects
   */
import 'package:flutter/material.dart';
import 'package:mobile/src/Pages/GradesPage/View/GradesSpecificViewPage.dart';

class GradesCard extends StatelessWidget {
  //Holds the lesson title
  final String subjectTitle;

  //Holds the lessonid
  final int totalGrade;

  //TODO: Make this a key value paired array
  final int marksArray;

//LessonCardConstructor. Takes in 4 arguments
  GradesCard(
      {required this.subjectTitle,
      required this.totalGrade,
      required this.marksArray});

  @override
  Widget build(BuildContext context) {
    return Column(
      // height: 400,
      // width: 400,
      //This is the main lesson card design. It is all in a container and
      //displays info like the lesson title, lesson objectives and
      //the lesson
      children: [
        Expanded(
          child: Card(
            semanticContainer: true,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: BorderSide(color: Colors.purple),
            ),
            clipBehavior: Clip.antiAlias,
            color: Colors.black,
            //This allows the card to be clickable so that when clicked,
            // it will go to the lessons description for that lesson
            child: new InkWell(
              //This redirects the page to the gradespecific page on tap
              //and passes in the marks array, subject title and total grade
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => GradesSpecificViewPage(
                      marksArray: this.marksArray,
                      subjectTitle: this.subjectTitle,
                      totalGrade: this.totalGrade,
                    ),
                  ),
                );
              },
              child: Container(),
            ),
            //),
          ),
        ),
      ],
    );
  }
}
