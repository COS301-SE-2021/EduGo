import 'package:flutter/material.dart';
import 'package:mobile/src/Components/GradesPageCardWidget.dart';
import 'package:mobile/src/Components/mobile_page_layout.dart';
import 'package:mobile/src/Pages/SubjectsPage/Controller/SubjectController.dart';
import 'package:mobile/src/Pages/SubjectsPage/Models/SubjectsModel.dart';
import 'package:momentum/momentum.dart';

class GradesPage extends StatefulWidget {
  GradesPage({Key? key}) : super(key: key);
  static String id = "grades";

  @override
  _GradesPageState createState() => _GradesPageState();
}

class _GradesPageState extends State<GradesPage> {
  @override
  Widget build(BuildContext context) {
    return MobilePageLayout(
      true,
      false,
      MomentumBuilder(
        controllers: [SubjectsController],
        builder: (context, snapshot) {
          //Used for momentum mvc model
          final subjects = snapshot<SubjectsModel>();

          //return Container(
          //decoration: BoxDecoration(border: Border.all(color: Colors.red)),
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
                      .map((subject) => GradesCard(
                            totalGrade: 10,
                            subjectTitle: subject.title,
                            marksArray: 2,
                          ))
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
