/**
 * This is the lesson information page. It simply displays
 * the relevant information about a lesson when a specific 
 * lesson card is clicked on
*/

import 'package:flutter/material.dart';
import 'package:mobile/src/Components/mobile_page_layout.dart';
import 'package:mobile/src/Pages/DetectMarkerPage/View/DetectMarkerPage.dart';
import 'package:mobile/src/Pages/QuizPage/View/QuizPage.dart';
import 'package:momentum/momentum.dart';

/*------------------------------------------------------------------------------
 *                        Lesson details View Page 
 *------------------------------------------------------------------------------
*/

class LessonInformationPage extends StatefulWidget {
  //This title variable holds the lesson
  //title of the card that was clicked on
  final String lessonTitle;

  //This lesson ID variable holds the lesson
  //id of the card that was clicked on
  final int lessonID;

  //This holds the lesson description. i.e What the lesson is about
  final String lessonDescription;

  //LessonPage constructor
  LessonInformationPage(
      {Key? key,
      required this.lessonTitle,
      required this.lessonID,
      required this.lessonDescription})
      : super(key: key);
  static String id = "lessons";

  @override
  _LessonInformationPageState createState() => _LessonInformationPageState(
        lessonTitle: this.lessonTitle,
        lessonID: this.lessonID,
        lessonDescription: this.lessonDescription,
      );
}

class _LessonInformationPageState extends State<LessonInformationPage> {
  final String lessonTitle;
  final int lessonID;
  final String lessonDescription;

  _LessonInformationPageState({
    required this.lessonTitle,
    required this.lessonID,
    required this.lessonDescription,
  });

  @override
  Widget build(BuildContext context) {
    return MobilePageLayout(
      //mobilepagelayout takes 3 arguments. 2 bools and a momentumbuilder.
      //the two bool represent side bar and navbar. so if true and true, them
      //the side bar and nav bar will be displayed.
      //i.e true=yes display, false=no do not display
      true,
      true,
      Container(
        //decoration: BoxDecoration(border: Border.all(color: Colors.red)),
        //child: SingleChildScrollView(
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.only(top: 25),
                child: Text(
                  lessonTitle,
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
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.only(top: 60),
                child: Text(
                  'Lesson Description',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  softWrap: true,
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    decoration: TextDecoration.underline,
                    decorationStyle: TextDecorationStyle.solid,
                    decorationColor: Colors.black,
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.only(top: 25),
                child: Text(
                  lessonDescription,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 10,
                  softWrap: true,
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 50),
              child: SizedBox(
                width: MediaQuery.of(context).size.width / 1,
                height: MediaQuery.of(context).size.width / 10,
                child: Align(
                  alignment: Alignment.center,
                  child: MaterialButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      side: BorderSide(color: Colors.black),
                    ),
                    onPressed: () {
                      MomentumRouter.goto(
                        context,
                        QuizPage,
                        params: QuizParam(lessonID, false, []),
                        transition: (context, page) {
                          return MaterialPageRoute(builder: (context) => page);
                        },
                      );
                    },
                    minWidth: 10,
                    height: 60,
                    child: Text(
                      "Go to lesson quizzes",
                      maxLines: 2,
                      softWrap: true,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: SizedBox(
                width: MediaQuery.of(context).size.width / 1,
                height: MediaQuery.of(context).size.width / 10,
                child: Align(
                  alignment: Alignment.center,
                  child: MaterialButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      side: BorderSide(color: Colors.black),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DetectMarkerPage()),
                      );
                    },
                    minWidth: 10,
                    height: 60,
                    child: Text(
                      "Go to virtual entity",
                      maxLines: 2,
                      softWrap: true,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      'Lesson Information Page',
    );
  }
}
