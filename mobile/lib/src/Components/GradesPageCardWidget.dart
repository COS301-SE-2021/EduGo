/**
   * This widget will be a stateless widget and is responsible for displaying the 
   * grades as cards. There will be a subject and grade that can be passed 
   * into the constructor when displaying the subjects
   */
import 'package:flutter/material.dart';
import 'package:mobile/src/Pages/GradesPage/View/GradesLessonPage.dart';

class GradesCard extends StatelessWidget {
  //Holds the lesson title
  final String subjectTitle;

  //Holds the lessonid
  final int totalGrade;

  //For the grades button
  //final Color colour;

  //TODO: Make this a key value paired array
  final int marksArray;

//LessonCardConstructor. Takes in 4 arguments
  GradesCard({
    required this.subjectTitle,
    required this.totalGrade,
    required this.marksArray,
    //required this.colour
  });

  @override
  Widget build(BuildContext context) {
    String marksDescription;
    Color backgroundColourForMark = Colors.blue;
    // int totalGradeAsInt = int.parse(this.totalGrade);
    String totalGradeAsString = "-";

    if (totalGrade == -1) {
      marksDescription = "Marks are currently unavailable for this course";
    } else if (marksArray / totalGrade * 100 < 50) {
      marksDescription = "Based on submitted work";
      backgroundColourForMark = Colors.red;
    } else if (marksArray / totalGrade * 100 < 70) {
      marksDescription = "Based on submitted work";
      backgroundColourForMark = Colors.orange;
    } else {
      marksDescription = "Based on submitted work";
      backgroundColourForMark = Colors.green;
    }
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
                    builder: (context) => GradesSpecificViewPage(
                      marksArray: this.marksArray,
                      subjectTitle: this.subjectTitle,
                      totalGrade: this.totalGrade,
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
                            color: backgroundColourForMark,
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              side: BorderSide(color: Colors.black),
                            ),
                            onPressed: () {},
                            //minWidth: 50,
                            //height: 60,
                            child: Text(
                              //'$totalGradeAsString' + '/' + '80',
                              '$totalGrade' + '/' + '80',

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
                          marksDescription,
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
