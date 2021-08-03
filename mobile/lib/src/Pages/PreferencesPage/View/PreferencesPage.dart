import 'package:flutter/material.dart';
import 'package:mobile/src/Components/mobile_page_layout.dart';
import 'package:mobile/src/Pages/PreferencesPage/Controller/Preferences.dart';

class PreferencesPage extends StatefulWidget {
  PreferencesPage({Key? key}) : super(key: key);
  static String id = "preferences";

  @override
  _PreferencesPageState createState() => _PreferencesPageState();
}

//todo use controller and momentum to manipulate user detils
class _PreferencesPageState extends State<PreferencesPage> {
  //user varaibles used to access
  final user = Preferences.user;

  @override
  Widget build(BuildContext context) {
    return MobilePageLayout(
      true,
      true,
      Container(child: Text("Preferences")),
    );
  }
}
