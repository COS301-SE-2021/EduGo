import 'package:flutter/material.dart';
import 'package:mobile/src/Components/mobile_page_layout.dart';

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
      Container(child: Text("Lessons")),
    );
  }
}
