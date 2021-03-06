/**
   * This widget will be a stateless widget and is responsible for displaying the 
   * subjects as cards. There will be a title, grade and subject image that can be passed 
   * into the constructor when displaying the subject cards.
*/
import 'package:flutter/material.dart';
import 'package:mobile/src/Pages/LessonsPage/Controller/LessonController.dart';
import 'package:mobile/src/Pages/LessonsPage/View/LessonsPage.dart';
import 'package:momentum/momentum.dart';

/*------------------------------------------------------------------------------
 *                 Subject Card used in the subject page 
 *------------------------------------------------------------------------------
 */

class SubjectCard extends StatelessWidget {
  //Holds the subject title
  final String title;

  //Holds the subject grade
  final int grade;

  //Holds the subject id (no longer needed)
  final int id;

  //Holds how many lessons are in the subject
  final int count;

  //Holds the subject image
  final String subjectImage;
  final String educator;

//This is the subject card constructor. it requires 5 arguments to be passed in
  SubjectCard(
      {required this.title,
      required this.grade,
      required this.id,
      required this.count,
      required this.educator,
      required this.subjectImage});

  @override
  Widget build(BuildContext context) {
    //This is the main subject card design. It is all in a container and
    //displays info like the subject photo, subject title, subject educator
    //and how many lessons are in that subject
    return Card(
      semanticContainer: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      clipBehavior: Clip.antiAlias,
      color: Colors.black,
      //This allows the card to be clickable so that when clicked,
      // it will go to the lessons for that subject
      child: new InkWell(
        onTap: () {
          //This redirects the page to the lessons page on tap
          //and passes in the subject title, and subject id
          // Leads to subjects page
          Momentum.controller<LessonsController>(context)
              .updateLesson(context, id, title);
          return;
        },
        child: Container(
          decoration: BoxDecoration(
            color: const Color(0xff7c94b6),
            image: DecorationImage(
              colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.4), BlendMode.hue),
              //     //FIX THE SUBJECT IMAGE SO THAT A SPECIFIC SUBJECT IMAGE
              //     //CAN ALWAYS BE DISPLAYED AND NOT THE MOCK IMAGE. FIX SUBJECT
              //     //CARD AND HAVE SOME OPACITY INVOLVED SO YOU CAN STILL SEE SUBJECT
              //     //TITLE AND EDUCATOR NAME
              //     'https://edugo-files.s3.af-south-1.amazonaws.com/subject-choice.jpg'),
              image: NetworkImage('${subjectImage}'),
              fit: BoxFit.fill,
            ),
          ),
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(top: 150, left: 20),
                  child: Material(
                    elevation: 20,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    color: Colors.black54,
                    child: Flexible(
                      child: Text(
                        '$title',
                        textAlign: TextAlign.left,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        softWrap: true,
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.white70,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(top: 20, left: 20),
                  child: Material(
                    elevation: 20,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    color: Colors.black54,
                    child: Flexible(
                      child: Text(
                        '$educator',
                        textAlign: TextAlign.left,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        softWrap: true,
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.white70,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
