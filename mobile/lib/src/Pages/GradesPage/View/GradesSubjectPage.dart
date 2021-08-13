/**
 * This is the grade subject page. This page shows the subjects
 * with the overall total of the students mark. When clicked, it
 * will take the student to the GradeLesson page.
 * It follows the mvc design pattern and is implemented using Momentum. 
 * The GradeSubject card widget is used to display the GradeSubject cards. 
 * The GradeController is passed into the MomentumBuilder widget and 
 * handles the api call to get the data and also handles the conversion 
 * from string to json. 
 * 
*/
import 'package:flutter/material.dart';
import 'package:mobile/src/Components/GradesSubjectCard.dart';
import 'package:mobile/src/Components/mobile_page_layout.dart';
import 'package:mobile/src/Pages/GradesPage/Controller/GradesController.dart';
import 'package:mobile/src/Pages/GradesPage/Model/GradesModel.dart';
import 'package:momentum/momentum.dart';

/*------------------------------------------------------------------------------
 *                       Grade Subject View Page 
 *------------------------------------------------------------------------------
*/

class GradesSubjectPage extends StatefulWidget {
  GradesSubjectPage({Key? key}) : super(key: key);
  static String id = "grades";

  @override
  _GradesSubjectState createState() => _GradesSubjectState();
}

class _GradesSubjectState extends State<GradesSubjectPage> {
  @override
  Widget build(BuildContext context) {
    return MobilePageLayout(
      true,
      false,
      MomentumBuilder(
        controllers: [GradesController],
        builder: (context, snapshot) {
          //Stores a snapshot of the current subject
          //list in the GradesModel page
          final subjects = snapshot<GradesModel>();

          return SingleChildScrollView(
            child: Column(
              children: [
                Align(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 25),
                    child: Text(
                      'Marks',
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
                  //This makes 2 cards appear. So effectively two cards per page. (2 rows, 1 card per row)
                  childAspectRatio: MediaQuery.of(context).size.height / 400,
                  primary: false,
                  //padding: const EdgeInsets.all(20),
                  crossAxisSpacing: 0,
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  mainAxisSpacing: 10,
                  //makes 1 cards per row
                  crossAxisCount: 1,
                  //Call subject card here and pass in all arguments required
                  children: subjects.subjects
                      .map(
                        (subject) =>
                            //Pass in the entire subjects list of lessons.
                            //Also pass in the subject title and the subject mark
                            GradesSubjectCard(
                          subjectLessons: subject.lessons,
                          subjectMark: subject.mark,
                          subjectTitle: subject.title,
                        ),
                      )
                      .toList(),
                ),
              ],
            ),
          );
          //If there are no subjects
        },
      ),
    );
  }
}
