import 'package:flutter/material.dart';
class Settings extends StatefulWidget {
  Settings({Key key}) : super(key: key);
  @override
  _SettingsState createState() => new _SettingsState();
}

class _SettingsState extends State<Settings> {
    @override
    Widget build(BuildContext context) {
      return new Scaffold(
        appBar: new AppBar(
          title: new Text('App Name'),
          ),
        body:
          new Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              new Text(
              "Settings",
                style: new TextStyle(fontSize:34.0,
                color: const Color(0xFF000000),
                fontWeight: FontWeight.w500,
                fontFamily: "Roboto"),
              )
            ]
    
          ),
    
      );
    }
}