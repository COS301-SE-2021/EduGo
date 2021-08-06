import 'package:flutter/material.dart';
import 'package:mobile/src/Components/mobile_page_layout.dart';
import 'package:mobile/src/Pages/DetectMarkerPage/View/DetectMarkerPage.dart';
import 'package:mobile/src/Pages/VirtualEntityPage/View/VirtualEntityPage.dart';

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

  // var date = DateTime.parse(lessonStartTime);

  _LessonInformationPageState(
      {required this.lessonTitle,
      required this.lessonID,
      required this.lessonDescription,
      required this.lessonStartTime,
      required this.lessonEndTime});

  @override
  Widget build(BuildContext context) {
    //Format the date objects by passing them from strings to date objects
    var startDate = DateTime.parse(this.lessonStartTime);
    var endDate = DateTime.parse(this.lessonEndTime);

    return MobilePageLayout(
      false,
      false,
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
            // Align(
            //   alignment: Alignment.center,
            //   child: Padding(
            //     padding: const EdgeInsets.only(top: 40),
            //     child: Row(
            //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //       children: [
            //         Text(
            //           'Start time: ' +
            //               startDate.day.toString() +
            //               '-' +
            //               startDate.month.toString() +
            //               '-' +
            //               startDate.year.toString(),
            //           overflow: TextOverflow.ellipsis,
            //           maxLines: 2,
            //           softWrap: false,
            //           style: TextStyle(
            //               fontSize: 25,
            //               fontWeight: FontWeight.bold,
            //               color: Colors.black),
            //         ),
            //         Icon(
            //           Icons.alarm_outlined,
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
            // Align(
            //   alignment: Alignment.center,
            //   child: Padding(
            //     padding: const EdgeInsets.only(top: 25),
            //     child: Row(
            //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //       children: [
            //         Text(
            //           'End time: ' +
            //               endDate.day.toString() +
            //               '-' +
            //               endDate.month.toString() +
            //               '-' +
            //               endDate.year.toString(),
            //           overflow: TextOverflow.ellipsis,
            //           maxLines: 2,
            //           softWrap: false,
            //           style: TextStyle(
            //               fontSize: 25,
            //               fontWeight: FontWeight.bold,
            //               color: Colors.black),
            //         ),
            //         Icon(
            //           Icons.alarm_outlined,
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.only(top: 60),
                child: Text(
                  'Lesson Description',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  softWrap: false,
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    decoration: TextDecoration.underline,
                    decorationStyle: TextDecorationStyle.solid,
                    //color: Colors.transparent,
                    decorationColor: Colors.black,
                    // shadows: [
                    //   Shadow(color: Colors.black, offset: Offset(0, -5))
                    // ],
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
                  maxLines: 4,
                  softWrap: false,
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.only(top: 80),
                child: Text(
                  'Lesson Outcomes',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  softWrap: false,
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    decoration: TextDecoration.underline,
                    decorationStyle: TextDecorationStyle.solid,
                    //color: Colors.transparent,
                    decorationColor: Colors.black,
                    // shadows: [
                    //   Shadow(color: Colors.black, offset: Offset(0, -5))
                    // ],
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.only(top: 25),
                child: Text(
                  //lessonOutcomes,
                  'The outcome of this lesson is to ensure every student' +
                      'is comfortable with the basics of algebra',
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 4,
                  softWrap: false,
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 150),
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
                    //minWidth: MediaQuery.of(context).size.width / 180,
                    minWidth: 10,
                    height: 60,
                    child:
                        // Icon(
                        //   Icons.add_outlined,
                        //   color: Colors.white,
                        // ),
                        Text(
                      "Get Started",
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
      // ),
    );
  }
}
