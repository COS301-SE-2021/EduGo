import 'package:flutter/material.dart';
import 'package:mobile/src/Components/mobile_page_layout.dart';
import 'package:mobile/src/Pages/LessonsPage/Controller/LessonController.dart';
import 'package:mobile/src/Pages/LessonsPage/Models/LessonsModel.dart';
import 'package:momentum/momentum.dart';

class LessonsPage extends StatefulWidget {
  LessonsPage({Key? key}) : super(key: key);
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
          return Column(
            children: lessons.lessons.map((e) => Text(e.title)).toList()
          );
        }
      ))
    ); 
  }
}
