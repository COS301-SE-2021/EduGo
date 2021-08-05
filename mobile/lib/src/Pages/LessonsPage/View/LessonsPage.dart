/**
 * This is the lessons page that displays all the lessons for a particular subject.
 * It uses the MVC design pattern with Momentum.
 */

import 'package:flutter/material.dart';
import 'package:mobile/src/Components/mobile_page_layout.dart';
import 'package:mobile/src/Pages/LessonsPage/Controller/LessonController.dart';
import 'package:mobile/src/Pages/LessonsPage/Models/LessonsModel.dart';
import 'package:momentum/momentum.dart';

class LessonsPage extends StatefulWidget {
  //Thi sis required to get the subject title of the card that was clicked on
  final String title;
  //LessonPage constructor
  LessonsPage({Key? key, required this.title}) : super(key: key);
  static String id = "lessons";

  @override
  _LessonsPageState createState() => _LessonsPageState();
}

class _LessonsPageState extends State<LessonsPage> {
  @override
  Widget build(BuildContext context) {
    return MobilePageLayout(
      false,
      true,
      Container(
        child: MomentumBuilder(
          controllers: [LessonsController],
          builder: (context, snapshot) {
            final lessons = snapshot<LessonsModel>();
            return Text(
                // children: lessons.lessons.map((e) => Text(e.title)).toList());
                '${widget.title}');
          },
        ),
      ),
    );
  }
}
