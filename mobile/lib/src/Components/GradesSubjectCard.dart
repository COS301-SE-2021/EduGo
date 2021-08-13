/**
   * This widget will be a stateless widget and is responsible for displaying 
   * the subjects as cards for the GradesSubjectPage. There will be a subject title 
   * and grade as a percentage displayed on the card. It uses the gradescontroller 
   * to make the api call which will return a list of subjects
   */
import 'package:flutter/material.dart';
import 'package:mobile/src/Pages/GradesPage/Model/Grades.dart';
import 'package:mobile/src/Pages/GradesPage/View/GradesLessonPage.dart';

class GradesSubjectCard extends StatelessWidget {
  //Holds the list of subjects returned from the api call
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
                    builder: (context) => GradesLessonPage(
                      lessonList: subjectLessons,
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
                              '$subjectMark',
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
                          //marksDescription,
                          'This is the mark currently',
                          //"",
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
            //),
          ),
        ),
      ],
    );
  }
}
