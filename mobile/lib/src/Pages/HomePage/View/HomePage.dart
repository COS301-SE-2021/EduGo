import 'package:flutter/material.dart';
import 'package:mobile/src/Components/mobile_page_layout.dart';

class HomePage extends StatefulWidget {
  HomePage(Key? key) : super(key: key);
  final key = Key('homePage');
  static String id = 'home';
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return MobilePageLayout(
      true,
      true,
      false,
      Container(child: Text("Home")),
      'Under Construction...',
    );
  }
}
