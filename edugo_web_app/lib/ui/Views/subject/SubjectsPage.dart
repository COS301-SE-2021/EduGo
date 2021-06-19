import 'package:edugo_web_app/ui/widgets/EduGoNav/NavBar.dart';
import 'package:edugo_web_app/ui/widgets/EduGoPage.dart';
import 'package:edugo_web_app/ui/widgets/subjectCard.dart';
import 'package:flutter/material.dart';

class SubjectsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: <Widget>[
        NavBar(),
        Container(
          padding: EdgeInsets.only(top: 40, bottom: 40, left: 100, right: 80),
          margin: EdgeInsets.only(left: 100, top: 100),
          width: MediaQuery.of(context).size.width - 100,
          height: MediaQuery.of(context).size.height - 100,
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.black,
              //width: 1,
              style: BorderStyle.solid,
            ),
          ),
          child: Column(children: <Widget>[
            Align(
              alignment: Alignment.centerLeft,
              child: SubjectCard(height: 330, width: 280),
            )
          ]),
        ),
      ],
    ));
  }
}
