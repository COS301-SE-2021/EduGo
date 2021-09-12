/**
 * This is the grade lesson page. This page shows the lessons of
 * a particular subject with the overall lesson mark that the student 
 * achieved. When clicked, it will take the student to the GradeQuiz page.
 * The GradeLesson card widget is used to display the GradeLesson cards.  
 * A GradesLesson Card will appear for all the lessons. However, if a lesson
 * does not have all of the quizzes completed, the student will not be 
 * allowed access into that card yet. The lesson mark will also be 
 * unavailable. But when all quizzes have been completed, the lesson
 * mark will be available. I.e. A student cannot view his/her quiz marks
 * until all quizzes for that lesson have been completed.
*/

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mobile/src/Components/GradesLessonCardWidget.dart';
import 'package:mobile/src/Components/mobile_page_layout.dart';
import 'package:mobile/src/Pages/GradesPage/Model/Grades.dart';

/*------------------------------------------------------------------------------
 *                       Grade Lesson View Page 
 *------------------------------------------------------------------------------
*/

class GradesLessonPage extends StatefulWidget {
  //Holds the list of lessons to be
  //passed in from the GradesLessonCard
  final List<Lesson> lessonList;

  GradesLessonPage({Key? key, required this.lessonList}) : super(key: key);

  @override
  _GradesLessonState createState() =>
      _GradesLessonState(lessonList: this.lessonList);
}

class _GradesLessonState extends State<GradesLessonPage> {
  final List<Lesson> lessonList;

  _GradesLessonState({
    required this.lessonList,
  });

  @override
  Widget build(BuildContext context) {
    //Null check to see if list is empty as well
    //as check to see if no subjects are in the list
    if (lessonList.isNotEmpty && lessonList.length > 0) {
      return MobilePageLayout(
        false,
        false,
        Container(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Align(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 25),
                    child: Text(
                      'Lesson Marks',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      softWrap: false,
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                  ),
                ),
                GridView.count(
                  //This makes 2 cards appear. So effectively
                  //two cards per page. (2 rows, 1 card per row)
                  childAspectRatio: MediaQuery.of(context).size.height / 300,
                  primary: false,
                  padding: const EdgeInsets.only(top: 20),
                  crossAxisSpacing: 0,
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  mainAxisSpacing: 10,
                  //makes 1 cards per row
                  crossAxisCount: 1,
                  //Call subject card here and pass in all arguments required
                  children: lessonList
                      .map(
                        (lesson) =>
                            //Pass in the entire lesson list of quizzes
                            //Also pass in the lesson title and the overall lesson mark
                            //as a percentage
                            GradesLessonCard(
                          lessonTitle: lesson.lessonName,
                          lessonMark: lesson.gradeAchieved,
                          quizList: lesson.quizGrades,
                        ),
                      )
                      .toList(),
                ),
              ],
            ),
          ),
        ),
      );

      //Display a spinner card if no mark for lessons or between api calls
    } else
      return SpinKitCircle(
        color: Colors.black,
      );
  }
}
