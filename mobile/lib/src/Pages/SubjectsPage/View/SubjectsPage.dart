import 'package:flutter/material.dart';
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
        //TODO replace the text widget with a List of subject card widgets, try using the map function to this in one line
        //Example: subjects.subjects.map(subject => SubjectCard(subject: subject));
        return Container(
          height: MediaQuery.of(context).size.height - 200,
          padding: EdgeInsets.only(top: 75),
          child: GridView.count(
            childAspectRatio: MediaQuery.of(context).size.height / 1000,
            primary: false,
            padding: const EdgeInsets.all(20),
            crossAxisSpacing: 30,
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            mainAxisSpacing: 20,
            crossAxisCount: 4,
            children: //subjects.subjects.map(subject => SubjectCard(subject: subject));
          ),
        );
      },
    ),);
  }
}
