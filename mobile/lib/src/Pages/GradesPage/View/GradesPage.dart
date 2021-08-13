import 'package:flutter/material.dart';
import 'package:mobile/src/Components/mobile_page_layout.dart';

class GradesPage extends StatefulWidget {
  GradesPage({Key? key}) : super(key: key);
  static String id = "grades";

  @override
  _GradesPageState createState() => _GradesPageState();
}

class _GradesPageState extends State<GradesPage> {
  @override
  Widget build(BuildContext context) {
    return MobilePageLayout(
      true,
      true,
      Container(child: Text("Grades")),
      "Grades",
    );
  }
}
