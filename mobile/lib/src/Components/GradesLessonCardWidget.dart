/**
   * This widget will be a stateless widget and is responsible for 
   * displaying the grades lesson cards for the GradesLesson page. 
   * There will be a lesson mark, title and a list of quizzes that 
   * can be passedinto the constructor when displaying the 
   * gradelesson cards.
*/
import 'package:flutter/material.dart';
import 'package:mobile/src/Pages/GradesPage/Model/Grades.dart';
import 'package:mobile/src/Pages/GradesPage/View/GradesQuizPage.dart';

/*------------------------------------------------------------------------------
 *              GradeLesson Cards used in the GradeLesson page 
 *------------------------------------------------------------------------------
*/

//TODO: UNCOMMENT THE ONTAP TO GO TO GRADE QUIZ CARDS TO
//SHOW THE QUIZ MARKS

class GradesLessonCard extends StatelessWidget {
  //Holds the list of quizzes
  //returned from the api call
  final List<Quiz> quizList;

  //Holds the lesson title
  final String lessonTitle;

  //Holds the lesson mark as a percentage
  final int lessonMark;

  //GradeLesson constructor
  GradesLessonCard(
      {required this.quizList,
      required this.lessonMark,
      required this.lessonTitle});

  @override
  Widget build(BuildContext context) {
    //Holds the colour of the backround container
    //of the marks container and changes accordingly
    Color backgroundOfMarkColour;

    //Used to identify whether there
    //is a mark of not for the lesson
    bool hasMark = false;

    //Checks if there is a mark and changes the bool value
    //It also changes the background colour of the mark container
    //depending on what catagory of percent the student falls in
    if (lessonMark < 0) {
      hasMark = false;
      backgroundOfMarkColour = Colors.white;
    } else if (lessonMark >= 0 && lessonMark < 50) {
      backgroundOfMarkColour = Colors.red;
      hasMark = true;
    } else if (lessonMark >= 50 && lessonMark < 60) {
      backgroundOfMarkColour = Colors.orange;
      hasMark = true;
    } else if (lessonMark >= 60 && lessonMark < 75) {
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
            ),
            clipBehavior: Clip.antiAlias,
            color: Color.fromARGB(0, 246, 246, 246),
            //This allows the card to be clickable so that when clicked,
            // it will go to the lessons description for that lesson
            child: new InkWell(
              //This redirects the page to the gradespecific page on tap
              //and passes in the marks array, lesson title and lesson grade
              onTap: () {
                // if (hasMark) {
                //   Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //       builder: (context) => GradesQuizPage(
                //         quizList: quizList,
                //       ),
                //     ),
                //   );
                // }
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
                            color: backgroundOfMarkColour,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(20),
                              ),
                              side: BorderSide(color: backgroundOfMarkColour),
                            ),
                            onPressed: () {},
                            child: Text(
                              //If it has a lessonmark, display it.
                              //Else display "--"
                              hasMark ? '$lessonMark' + '%' : "--",
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
                    Align(
                      alignment: Alignment.center,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 25),
                        child: Text(
                          '$lessonTitle',
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
