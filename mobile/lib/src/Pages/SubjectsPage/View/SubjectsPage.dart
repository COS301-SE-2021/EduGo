/**
 * This is the subject page view. It follows the MVC design pattern and is implemented
 * using Momentum. The subjectCard widget is used along side the subject page controller
 * to populate the card.
 */
import 'package:flutter/material.dart';
import 'package:mobile/src/Components/SubjectCardWidget.dart';
import 'package:mobile/src/Pages/SubjectsPage/Controller/SubjectController.dart';
import 'package:mobile/src/Pages/SubjectsPage/Models/SubjectsModel.dart';
import 'package:momentum/momentum.dart';

class SubjectsPage extends StatefulWidget {
  SubjectsPage({Key? key}) : super(key: key);

  @override
  _SubjectsPageState createState() => _SubjectsPageState();
}

class _SubjectsPageState extends State<SubjectsPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: MomentumBuilder(
        controllers: [SubjectsController],
        builder: (context, snapshot) {
          final subjects = snapshot<SubjectsModel>();
          return Container(
            height: MediaQuery.of(context).size.height - 200,
            padding: EdgeInsets.only(top: 75),
            //grid view arranges the cards into a grid format to be displayed neatly on the page
            child: GridView.count(
                childAspectRatio: MediaQuery.of(context).size.height / 1000,
                primary: false,
                padding: const EdgeInsets.all(20),
                crossAxisSpacing: 30,
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                mainAxisSpacing: 20,
                crossAxisCount: 2,
                children: subjects.subjects
                    .map((subject) => SubjectCard(
                        title: subject.title,
                        grade: subject.grade,
                        id: subject.id))
                    .toList()),
          );
        },
      ),
    );
  }
}
