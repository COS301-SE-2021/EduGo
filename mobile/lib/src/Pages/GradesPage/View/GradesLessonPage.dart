/**
 * This is the grade lesson page. This page shows the lessons of
 * a particular subject with the overall lesson mark that the student 
 * achieved. When clicked, it will take the student to the GradeQuiz page.
 * The GradeLesson card widget is used to display the GradeLesson cards.  
*/

import 'package:flutter/material.dart';
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
    return MobilePageLayout(
      true,
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
                        lessonTitle: lesson.title,
                        lessonMark: lesson.mark,
                        quizList: lesson.quizzes,
                      ),
                    )
                    .toList(),
              ),
            ],
          ),
        ),
      ),
      'Grades Lesson Page',
    );
  }
}
