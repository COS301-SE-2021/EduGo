import 'package:flutter/material.dart';
import 'package:mobile/common_widgets/nav_containers/bottom_nav_bar.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => new _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Column(children: <Widget>[
        Flexible(
          child: new FractionallySizedBox(
            child: new Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  new Text(
                    "Settings",
                    style: new TextStyle(
                        fontSize: 48.0,
                        color: const Color(0xFF000000),
                        fontWeight: FontWeight.w500,
                        fontFamily: "Roboto"),
                  )
                ]),
            widthFactor: 0.90,
            heightFactor: 0.90,
          ),
        ),
        Flexible(
          child: Row(),
          //child: Bottom_Nav_Bar(destination: destination,)
        ),
      ]),
    );
  }
}
