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
    //TODO:
    //Make an if statement to check mark and make a variable to say
    //'This is the mark ' currently or if no mark available it must say
    //No marks avaiable yet.. check clickup for reference
    return Column(
      children: [
        Expanded(
          child: Card(
            semanticContainer: true,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: BorderSide(color: Colors.purple),
            ),
            clipBehavior: Clip.antiAlias,
            color: Colors.green,
            //This allows the card to be clickable so that when clicked,
            // it will go to the lessons description for that lesson
            child: new InkWell(
              //This redirects the page to the gradespecific page on tap
              //and passes in the marks array, subject title and total grade
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => GradesQuizPage(
                      quizList: quizList,
                    ),
                  ),
                );
              },
              child: Container(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.width / 10,
                        // child: DecoratedBox(
                        // decoration: BoxDecoration(color: Colors.purple),
                        //),

                        child: Align(
                          alignment: Alignment.topCenter,
                          child: MaterialButton(
                            //color: backgroundColourForMark,
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              side: BorderSide(color: Colors.black),
                            ),
                            onPressed: () {},
                            child: Text(
                              '$lessonMark',
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
                    // Align(
                    //   alignment: Alignment.bottomCenter,
                    //   child: Padding(
                    //     padding: const EdgeInsets.only(top: 15),
                    //     child: Text(
                    //       //marksDescription,
                    //       'This is the mark currently',
                    //       //"",
                    //       textAlign: TextAlign.center,
                    //       overflow: TextOverflow.ellipsis,
                    //       maxLines: 4,
                    //       softWrap: false,
                    //       style: TextStyle(
                    //           fontSize: 18,
                    //           fontWeight: FontWeight.bold,
                    //           color: Colors.black),
                    //     ),
                    //   ),
                    // ),
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
