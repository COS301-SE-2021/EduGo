/**
 * This is the subject page. It follows the mvc design pattern 
 * and is implemented using Momentum. The subjectCard widget 
 * is used to display the subject cards. The subjectController is 
 * passed into the MomentumBuilder widget and handles the api call 
 * to get the data and also handles the conversion from string to json. 
*/

import 'package:flutter/material.dart';
import 'package:mobile/src/Components/mobile_page_layout.dart';
import 'package:mobile/src/Components/SubjectCardWidget.dart';
import 'package:mobile/src/Pages/SubjectsPage/Controller/SubjectController.dart';
import 'package:mobile/src/Pages/SubjectsPage/Models/SubjectsModel.dart';
import 'package:momentum/momentum.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

/*------------------------------------------------------------------------------
 *                            Subject View Page 
 *------------------------------------------------------------------------------
*/

class SubjectsPage extends StatefulWidget {
  SubjectsPage({Key? key}) : super(key: key);
  static String id = "subjects";

  @override
  _SubjectsPageState createState() => _SubjectsPageState();
}

class _SubjectsPageState extends State<SubjectsPage> {
  @override
  Widget build(BuildContext context) {
    //mobilepagelayout takes 3 arguments. 2 bools and a momentumbuilder.
    //the two bool represent side bar and navbar. so if true and true, them
    //the side bar and nav bar will be displayed.
    //i.e true=yes display, false=no do not display
    return MobilePageLayout(
      true,
      true,
      MomentumBuilder(
        controllers: [SubjectsController],
        builder: (context, snapshot) {
          //Stores a snapshot of the current subject
          //list in the SubjectModel page
          final subjects = snapshot<SubjectsModel>();
          //Stores the number of subjects for a particulat student
          int subjectsCount = subjects.subjects.length;

          if (subjectsCount > 0)
          //print('no of subjects: ' + subjectsCount.toString());
          if (subjects.subjects.isEmpty) print('no subjects');
          //A check to see if there are subjects. If there are no subjects,
          //or if the list is empty display another card saying no
          //subjects are available
          final subjectsController =
              Momentum.controller<SubjectsController>(context);
          //Call this function on every reload or click of
          //page to display new subjects
          subjectsController.getSubjects();
          if (subjectsCount > 0 && subjects.subjects.isNotEmpty) {
            return Container(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Align(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 25),
                        child: Text(
                          'Subjects',
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
                      childAspectRatio:
                          MediaQuery.of(context).size.height / 520,
                      primary: false,
                      padding: const EdgeInsets.all(10),
                      crossAxisSpacing: 0,
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      mainAxisSpacing: 20,
                      //makes 1 cards per row
                      crossAxisCount: 1,
                      //Call subject card here and pass in all arguments required
                      children: subjects.subjects
                          .map(
                            (subject) => SubjectCard(
                              title: subject.title,
                              grade: subject.grade,
                              id: subject.id,
                              count: subjectsCount,
                              educator: "Ms Kim Possible",
                              subjectImage: subject.image,
                              //subject.educatorName
                            ),
                          )
                          .toList(),
                    ),
                  ],
                ),
              ),
            );
          }
          //Display a spinner card if no mark for lessons
          //or between api calls
          else
            return SpinKitCircle(
              color: Colors.black,
            );
        },
      ),
      'Subjects',
    );
  }
}
