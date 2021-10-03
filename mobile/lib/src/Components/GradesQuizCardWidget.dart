/**
   * This widget will be a stateless widget and is responsible for 
   * displaying the grades quiz cards for the GradesQuiz page. 
   * There will be a student mark, overall quiz mark, title and 
   * quiz id that can be passed into the constructor when displaying the 
   * gradequiz cards.
**/
import 'package:flutter/material.dart';
import 'package:mobile/src/Pages/GradesPage/Model/Grades.dart';
import 'package:mobile/src/Pages/GradesPage/View/GradesQuizSpecificsPage.dart';

/*------------------------------------------------------------------------------
 *              GradeQuiz Cards used in the GradeQuiz page 
 *------------------------------------------------------------------------------
*/

class GradesQuizCard extends StatelessWidget {
  //Holds the quiz name
  final String name;

  //Holds the mark that the student received for the quiz
  final int studentQuizMark;

  //Holds the total mark that the quiz was out of
  final int quizTotalMark;

  //Holds the quiz answers array
  final List<QuizAnswers> quizAnswers;

  final int count;

//QuizCardConstructor. Takes in 4 arguments
  GradesQuizCard(
      {required this.quizTotalMark,
      required this.studentQuizMark,
      required this.quizAnswers,
      required this.name,
      required this.count});

  @override
  Widget build(BuildContext context) {
    int counter = this.count + 1;
    return Column(
      //This is the main lesson card design. It is all in a container and
      //displays info like the lesson title, lesson objectives and
      //the lesson
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
              //and passes in the marks array, subject title and total grade
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        GradesQuizSpecificsPage(quizAnswers: this.quizAnswers),
                  ),
                );
              },
              child: Container(
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.topCenter,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Flexible(
                          child: Text(
                            "Quiz " + '$counter'.toString(),
                            textAlign: TextAlign.left,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 3,
                            softWrap: true,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.width / 10,
                        child: Align(
                          alignment: Alignment.topCenter,
                          child: MaterialButton(
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              side: BorderSide(color: Colors.black),
                            ),
                            onPressed: () {},
                            child: Text(
                              '$studentQuizMark' + '/' + '$quizTotalMark',
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
