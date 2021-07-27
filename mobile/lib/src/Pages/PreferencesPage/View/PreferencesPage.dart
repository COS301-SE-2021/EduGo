import 'package:flutter/material.dart';
import 'package:mobile/src/Pages/PreferencesPage/Controller/Preferences.dart';

class PreferencesPage extends StatefulWidget {
  PreferencesPage({Key? key}) : super(key: key);

  @override
  _PreferencesPageState createState() => _PreferencesPageState();
}

//todo use controller and momentum to manipulate user detils
class _PreferencesPageState extends State<PreferencesPage> {
  //user varaibles used to access
  final user = Preferences.user;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("Preferences"),
    );
  }
}
//D:\Users\u19187166\Desktop\EduGo\mobile\lib\src\assets
