import 'dart:html';

import 'package:flutter/material.dart';
import 'package:mobile/src/Components/mobile_page_layout.dart';

class LessonInformationPage extends StatefulWidget {
  //This title variable holds the lesson title of the card that was clicked on
  final String lessonTitle;
  //This holds the specific lesson ID
  final int lessonID;
  //This holds the lesson outcomes. i.e What the educator hopes to teach
  //in the lesson
  //final String lessonOutcomes;
  //This holds the lesson description. i.e What the lesson is about
  final String lessonDescription;
  //This holds the start time of the lesson
  final String lessonStartTime;
  //This holds the end time of the lesson
  final String lessonEndTime;

  //This title variable holds the subject count of the card that was clicked on
  //final int SubjectCount;
  //LessonPage constructor
  LessonInformationPage(
      {Key? key,
      required this.lessonTitle,
      required this.lessonID,
      required this.lessonStartTime,
      required this.lessonEndTime,
      required this.lessonDescription})
      : super(key: key);
  static String id = "lessons";

  @override
  _LessonInformationPageState createState() => _LessonInformationPageState(
        lessonTitle: this.lessonTitle,
        lessonID: this.lessonID,
        lessonDescription: this.lessonDescription,
        lessonStartTime: this.lessonStartTime,
        lessonEndTime: this.lessonEndTime,
      );
}

class _LessonInformationPageState extends State<LessonInformationPage> {
  final String lessonTitle;
  final int lessonID;
  //final String lessonOutcomes;
  final String lessonDescription;
  final String lessonStartTime;
  final String lessonEndTime;

  _LessonInformationPageState(
      {required this.lessonTitle,
      required this.lessonID,
      required this.lessonDescription,
      required this.lessonStartTime,
      required this.lessonEndTime});

  @override
  Widget build(BuildContext context) {
    return MobilePageLayout(
      false,
      true,
      Container(),
    );
  }
}
