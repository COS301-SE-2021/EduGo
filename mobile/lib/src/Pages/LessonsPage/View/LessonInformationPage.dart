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
        child: ListView(
            padding: EdgeInsets.only(top: 50, bottom: 100, left: 40, right: 40),
            children: [
              Column(
                //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  //Lesson title, aligned top left. Button leading to Quiz top right
                  new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        new Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            lessonTitle,
                            style: TextStyle(
                              fontSize: 25,
                            ),
                          ),
                        ),
                        new Align(
                          alignment: Alignment.topRight,
                          child: MaterialButton(
                              elevation: 20,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                              onPressed: () {
                                MomentumRouter.goto(
                                  context,
                                  QuizPage,
                                  params: QuizParam(lessonID),
                                  transition: (context, page) {
                                    return MaterialPageRoute(
                                        builder: (context) => page);
                                  },
                                );
                              },
                              minWidth: 10,
                              height: 25,
                              color: Color.fromARGB(255, 97, 211, 87),
                              disabledColor: Color.fromRGBO(211, 212, 217, 1),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: <Widget>[
                                    Icon(
                                      Icons.post_add,
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                    Text(
                                      "Quizzes",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ],
                                ),
                              )),
                        ),
                      ]),
                  //Lesson description
                  Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 25),
                      child: Text(
                        lessonDescription,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 10,
                        softWrap: true,
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                    ),
                  ),

                  //Scan QR code
                  Padding(
                    padding: const EdgeInsets.only(top: 15.0, bottom: 8.0),
                    child: MaterialButton(
                        elevation: 20,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        onPressed: () {
                          MomentumRouter.goto(
                            context,
                            DetectMarkerPage,
                            transition: (context, page) {
                              return MaterialPageRoute(
                                  builder: (context) => page);
                            },
                          );
                        },
                        minWidth: 10,
                        height: 25,
                        color: Color.fromARGB(255, 97, 211, 87),
                        disabledColor: Color.fromRGBO(211, 212, 217, 1),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: <Widget>[
                              Icon(
                                Icons.qr_code,
                                color: Colors.white,
                                size: 20,
                              ),
                              Text(
                                "Scan QR code",
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        )),
                  ),

                  //Virtual entities display:
                  //the number of tabs represent the no of virual entity
                  // each virtual entity is labeled by it's id

                  //Tab controller to keep the selected tab and content sections in sync.
                  DefaultTabController(
                    // The number of tabs / content sections to display.
                    length: 3,
                    child: Text(''),
                  ),
                ],
              ),
            ]),
      ),
      'Lesson Information Page',
    );
  }
}
