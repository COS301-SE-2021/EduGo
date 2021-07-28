import 'package:flutter/material.dart';
import 'package:mobile/src/Components/mobile_page_layout.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return MobilePageLayout(
      Text("Home"),
    );
  }
}
