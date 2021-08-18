/**
   * This widget will be a stateless widget and is responsible for 
   * displaying the grades subject cards for the GradesSubject page. 
   * There will be a subject title, mark and a list of lessons that 
   * can be passed into the constructor when displaying the 
   * gradeSubject cards.
**/
import 'package:flutter/material.dart';
import 'package:mobile/src/Pages/GradesPage/Model/Grades.dart';
import 'package:mobile/src/Pages/GradesPage/View/GradesLessonPage.dart';

/*------------------------------------------------------------------------------
 *              GradeSubject Cards used in the GradeQuiz page 
 *------------------------------------------------------------------------------
*/

class GradesSubjectCard extends StatelessWidget {
  //Holds the list of subjects
  //returned from the api call
  final List<Lesson> subjectLessons;

  //Holds the subject title
  final String subjectTitle;

  //Holds the subject mark as a percentage
  final int subjectMark;

  //Constructor
  GradesSubjectCard(
      {required this.subjectLessons,
      required this.subjectMark,
      required this.subjectTitle});

  @override
  Widget build(BuildContext context) {
    //Holds the colour of the backround container
    //of the marks container and changes accordingly
    Color backgroundOfMarkColour;

    //Used to identify whether there
    //is a mark of not for the subject
    bool hasMark = false;

    //If there is a mark for the subject, display this discription
    String markDescription1 = "Based on submitted work";

    //If there is no mark for the subject (i.e returns -1), display this discription
    String markDescription2 = "Marks are currently unavailable for this course";

    //Checks if there is a mark and changes the bool value
    //It also changes the background colour of the mark container
    //depending on what catagory of percent the student falls in
    if (subjectMark < 0 ||
        subjectLessons.isEmpty ||
        subjectLessons.length < 0) {
      hasMark = false;
      backgroundOfMarkColour = Colors.white;
    } else if (subjectMark >= 0 && subjectMark < 50) {
      backgroundOfMarkColour = Colors.red;
      hasMark = true;
    } else if (subjectMark >= 50 && subjectMark < 60) {
      backgroundOfMarkColour = Colors.orange;
      hasMark = true;
    } else if (subjectMark >= 60 && subjectMark < 75) {
      backgroundOfMarkColour = Colors.yellow;
      hasMark = true;
    } else {
      backgroundOfMarkColour = Colors.green;
      hasMark = true;
    }

    return Column(
      children: [
        Expanded(
          child: Card(
            semanticContainer: true,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              //borderRadius: BorderRadius.zero;
              //side: BorderSide(color: Colors.purple),
            ),
            clipBehavior: Clip.antiAlias,
            color: Color.fromARGB(0, 246, 246, 246),
            child: new InkWell(
              //This allows the card to be clickable so that when clicked,
              // it will go to the lessons description for that lesson
              onTap: () {
                //If the subject has a mark, make the card clickable and redirect
                //to the GradesLessonPage and show the lesson marks. Else don't
                //make the card clickable
                if (hasMark) {
                  //This redirects the page to the gradespecific page on tap
                  //and passes in the marks array, subject title and total grade
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => GradesLessonPage(
                        lessonList: subjectLessons,
                      ),
                    ),
                  );
                }
              },
              child: Container(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.width / 10,
                        child: Align(
                          alignment: Alignment.topCenter,
                          child: MaterialButton(
                            //Make the colour of the button the
                            //background of the one chosen from the
                            //if statement done above
                            color: backgroundOfMarkColour,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(20),
                              ),
                              side: BorderSide(color: backgroundOfMarkColour),
                            ),
                            onPressed: () {},
                            child: Text(
                              //If there is a subject mark, display it.
                              //Else display the two dashes
                              hasMark ? '$subjectMark' + '%' : "--",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                          ),
                        ),
                      ),
                    ),
                    // ),
                    Align(
                      alignment: Alignment.center,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 25),
                        child: Text(
                          '$subjectTitle',
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 4,
                          softWrap: false,
                          style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 15),
                        child: Text(
                          //If there is a mark, display description 1.
                          //Else display description two.
                          hasMark ? markDescription1 : markDescription2,
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 4,
                          softWrap: false,
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
