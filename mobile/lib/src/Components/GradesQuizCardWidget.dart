/**
   * This widget will be a stateless widget and is responsible for 
   * displaying the grades quiz cards for the GradesQuiz page. 
   * There will be a student mark, overall quiz mark, title and 
   * quiz id that can be passed into the constructor when displaying the 
   * gradequiz cards.
**/
import 'package:flutter/material.dart';
import 'package:mobile/src/Pages/GradesPage/View/GradesQuizSpecificsPage.dart';

/*------------------------------------------------------------------------------
 *              GradeQuiz Cards used in the GradeQuiz page 
 *------------------------------------------------------------------------------
*/

class GradesQuizCard extends StatelessWidget {
  //Holds the quiz title
  // final String quizTitle;

  //Holds the quiz id
  // final int id;

  //Holds the mark that the student received for the quiz
  final int studentQuizMark;

  //Holds the total mark that the quiz was out of
  final int quizTotalMark;

  // //Holds the student answers from the quiz
  // final List<String> studentAnswers;

  // //Holds the correct answers from the quiz
  // final List<String> correctAnswers;

//QuizCardConstructor. Takes in 4 arguments
  GradesQuizCard({
    required this.quizTotalMark,
    required this.studentQuizMark,
  });

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
              //side: BorderSide(color: Colors.purple),
            ),
            clipBehavior: Clip.antiAlias,
            //color: Colors.green,
            color: Color.fromARGB(0, 246, 246, 246),
            //This allows the card to be clickable so that when clicked,
            // it will go to the lessons description for that lesson
            child: new InkWell(
              //This redirects the page to the gradespecific page on tap
              //and passes in the marks array, subject title and total grade
              onTap: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => GradesQuizSpecificsPage(
                //       studentQuizMark: this.studentQuizMark,
                //       quizTotalMark: this.quizTotalMark,
                //     ),
                //   ),
                // );
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
                            // color: backgroundColourForMark,
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              side: BorderSide(color: Colors.black),
                            ),
                            onPressed: () {},
                            //minWidth: 50,
                            //height: 60,
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
                    // ),
                    // Align(
                    //   alignment: Alignment.center,
                    //   child: Padding(
                    //     padding: const EdgeInsets.only(top: 25),
                    //     child: Text(
                    //       '$quizTitle',
                    //       textAlign: TextAlign.center,
                    //       overflow: TextOverflow.ellipsis,
                    //       maxLines: 4,
                    //       softWrap: false,
                    //       style: TextStyle(
                    //           fontSize: 22,
                    //           fontWeight: FontWeight.bold,
                    //           color: Colors.black),
                    //     ),
                    //   ),
                    // ),
                    // Align(
                    //   alignment: Alignment.bottomCenter,
                    //   child: Padding(
                    //     padding: const EdgeInsets.only(top: 15),
                    //     child: Text(
                    //       "marksDescription",
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
