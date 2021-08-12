import 'package:flutter/material.dart';
import 'package:mobile/src/Components/mobile_page_layout.dart';

class GradesSpecificViewPage extends StatefulWidget {
  //This holds the specific lesson ID
  //final array[] marksArray;
  final int marksArray;

  //Holds the lesson title
  final String subjectTitle;

  //Holds the lessonid
  final int totalGrade;

  //LessonPage constructor
  GradesSpecificViewPage(
      {Key? key,
      required this.marksArray,
      required this.subjectTitle,
      required this.totalGrade})
      : super(key: key);
  static String id = "lessons";

  @override
  _GradesSpecificViewPageState createState() => _GradesSpecificViewPageState(
      marksArray: this.marksArray,
      subjectTitle: this.subjectTitle,
      totalGrade: this.totalGrade);
}

class _GradesSpecificViewPageState extends State<GradesSpecificViewPage> {
  //final array[] marksArray;
  final int marksArray;

  final String subjectTitle;

  final int totalGrade;

  // var date = DateTime.parse(lessonStartTime);

  //Soon take out start time and end time

  _GradesSpecificViewPageState(
      {required this.marksArray,
      required this.subjectTitle,
      required this.totalGrade});

  @override
  Widget build(BuildContext context) {
    //Format the date objects by passing them from strings to date objects
    return MobilePageLayout(
      //mobilepagelayout takes 3 arguments. 2 bools and a momentumbuilder.
      //the two bool represent side bar and navbar. so if true and true, them
      //the side bar and nav bar will be displayed.
      //i.e true=yes display, false=no do not display
      false,
      false,
      Container(
        decoration: BoxDecoration(border: Border.all(color: Colors.red)),
        //child: SingleChildScrollView(
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.only(top: 25),
                child: Text(
                  subjectTitle,
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
                padding: const EdgeInsets.only(top: 25),
                child: Text(
                  'test',
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
                    onPressed: () {},
                    minWidth: 10,
                    height: 60,
                    child: Text(
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
