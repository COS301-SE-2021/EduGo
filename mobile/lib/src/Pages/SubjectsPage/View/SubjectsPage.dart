/**
 * This is the subject page view. It follows the MVC design pattern and is implemented
 * using Momentum. The subjectCard widget is used along side the subject page controller
 * to populate the card.
 */

import 'package:flutter/material.dart';
import 'package:mobile/src/Components/mobile_page_layout.dart';
import 'package:mobile/src/Components/SubjectCardWidget.dart';
import 'package:mobile/src/Pages/SubjectsPage/Controller/SubjectController.dart';
import 'package:mobile/src/Pages/SubjectsPage/Models/SubjectsModel.dart';
import 'package:momentum/momentum.dart';

class SubjectsPage extends StatefulWidget {
  SubjectsPage({Key? key}) : super(key: key);
  static String id = "subjects";

  @override
  _SubjectsPageState createState() => _SubjectsPageState();
}

class _SubjectsPageState extends State<SubjectsPage> {
  @override
  Widget build(BuildContext context) {
    return MobilePageLayout(
      true,
      true,
      //Container(
      MomentumBuilder(
        controllers: [SubjectsController],
        builder: (context, snapshot) {
          //Used for momentum mvc model
          final subjects = snapshot<SubjectsModel>();
          //Get the number of subjects for a particulat student
          int subjectsCount = subjects.subjects.length;
          if (subjectsCount > 0) {
            return Container(
              //decoration: BoxDecoration(border: Border.all(color: Colors.red)),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Align(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 25),
                        child: Text(
                          //'Title: +'
                          //widget.title,
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
                    // Align(
                    //   child: Padding(
                    //     padding: const EdgeInsets.only(top: 25),
                    //     child: Text(
                    //       //'Title: +'
                    //       '$subjectsCount' + ' subjects',
                    //       overflow: TextOverflow.ellipsis,
                    //       maxLines: 2,
                    //       softWrap: false,
                    //       style: TextStyle(
                    //           fontSize: 30,
                    //           fontWeight: FontWeight.bold,
                    //           color: Colors.black),
                    //     ),
                    //   ),
                    // ),
                    //return Container(
                    //height: MediaQuery.of(context).size.height - 100,
                    //padding: EdgeInsets.only(top: 75),
                    //grid view arranges the cards into a grid format to be displayed neatly on the page
                    GridView.count(
                      //This makes 2 cards appear. So effectively two cards per page. (2 rows, 1 card per row)
                      childAspectRatio:
                          MediaQuery.of(context).size.height / 600,
                      primary: false,
                      padding: const EdgeInsets.all(20),
                      crossAxisSpacing: 0,
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      mainAxisSpacing: 10,
                      //makes 1 cards per row
                      crossAxisCount: 1,
                      children: subjects.subjects
                          .map((subject) => SubjectCard(
                              title: subject.title,
                              grade: subject.grade,
                              id: subject.id,
                              count: subjectsCount))
                          .toList(),
                    ),
                  ],
                ),
              ),
            );
          } else
            return Container(
              child: Text('There are currently no subjects'),
            );
        },
      ),
    );
  }
}
