import 'package:flutter/material.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => new _SettingsState();
}

class _SettingsState extends State<Settings> {
    @override
    Widget build(BuildContext context) {
      return new Scaffold(
        body:
          new FractionallySizedBox(
            child:
              new Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  new Text(
                  "Settings",
                    style: new TextStyle(fontSize:48.0,
                    color: const Color(0xFF000000),
                    fontWeight: FontWeight.w500,
                    fontFamily: "Roboto"),
                  )
                ]
    
              ),
    
            widthFactor: 1.00, heightFactor: 1.00,
          ),
    
      );
    }
}