import 'package:flutter/material.dart';
import 'package:mobile/src/Components/Nav/Bottom/View/bottom_bar.dart';
import 'package:mobile/src/Components/mobile_page_layout.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);
  static String id = "home";
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return MobilePageLayout(
      true,
      true,
      Container(child: Text("Home")),
    );
  }
}
