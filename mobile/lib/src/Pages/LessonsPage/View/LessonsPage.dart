/**
 * This is the lesson page. It follows the mvc design pattern 
 * and is implemented using Momentum. The lessonCard widget 
 * is used to display the lesson cards. The lessonController is 
 * passed into the MomentumBuilder widget and handles the api call 
 * to get the data and also handles the conversion from string to json 
 */

import 'package:flutter/material.dart';
import 'package:mobile/src/Components/mobile_page_layout.dart';
import 'package:mobile/src/Pages/LessonsPage/Controller/LessonController.dart';
import 'package:mobile/src/Pages/LessonsPage/Models/LessonsModel.dart';
import 'package:momentum/momentum.dart';

/*------------------------------------------------------------------------------
 *                          Lesson View Page  
 *------------------------------------------------------------------------------
 */
class LessonsPage extends StatefulWidget {
  LessonsPage({Key? key}) : super(key: key);

  @override
  _LessonsPageState createState() => _LessonsPageState();
}

class _LessonsPageState extends State<LessonsPage> {
  @override
  Widget build(BuildContext context) {
    MomentumBuilder child = MomentumBuilder(
        controllers: [LessonsController],
        builder: (context, snapshot) {
          var lessonsPage = snapshot<LessonsModel>();

          return lessonsPage.view;
        });
    return MobilePageLayout(false, true, child, 'Lessons');
  }
}
