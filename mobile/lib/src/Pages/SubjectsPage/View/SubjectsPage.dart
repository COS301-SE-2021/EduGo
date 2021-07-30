import 'package:flutter/material.dart';
import 'package:mobile/src/Components/mobile_page_layout.dart';

class SubjectsPage extends StatefulWidget {
  SubjectsPage({Key? key}) : super(key: key);
  static String id = "subjects";

  @override
  _SubjectsPageState createState() => _SubjectsPageState();
}

class _SubjectsPageState extends State<SubjectsPage> {
  @override
  Widget build(BuildContext context) {
    return MobilePageLayout(
      true,
      true,
      Container(child: Text("Subjects")),
    );
  }
}
