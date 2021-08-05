/**
 * This is the lessons page that displays all the lessons for a particular subject.
 * It uses the MVC design pattern with Momentum.
 */

import 'package:flutter/material.dart';
import 'package:mobile/src/Components/LessonsCardWidgets.dart';
import 'package:mobile/src/Components/mobile_page_layout.dart';
import 'package:mobile/src/Pages/LessonsPage/Controller/LessonController.dart';
import 'package:mobile/src/Pages/LessonsPage/Models/LessonsModel.dart';
import 'package:momentum/momentum.dart';

class LessonsPage extends StatefulWidget {
  //This title variable holds the subject title of the card that was clicked on
  final String title;
  //This title variable holds the subject count of the card that was clicked on
  //final int SubjectCount;
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
      //Container(
      MomentumBuilder(
        controllers: [LessonsController],
        builder: (context, snapshot) {
          //Used for momentum mvc model
          final lessons = snapshot<LessonsModel>();
          //Get the number of lessons for a particular subject
          int lessonsCount = lessons.lessons.length;
          return Container(
            decoration: BoxDecoration(border: Border.all(color: Colors.red)),
            // children: lessons.lessons.map((e) => Text(e.title)).toList());
            //'${widget.title}');
            child: Column(
              children: [
                Align(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 25),
                    child: Text(
                      //'Title: +'
                      widget.title,
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
                  childAspectRatio: MediaQuery.of(context).size.height / 200,
                  primary: false,
                  padding: const EdgeInsets.all(20),
                  crossAxisSpacing: 0,
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  mainAxisSpacing: 10,
                  //makes 1 cards per row
                  crossAxisCount: 1,
                  children: lessons.lessons
                      .map(
                        (lesson) => LessonsCard(
                          title: lesson.title,
                        ),
                      )
                      .toList(),
                ),
              ],
            ),
          );
        },
        //),
      ),
    );
  }
}
