import 'package:flutter/material.dart';
import 'package:mobile/DetectMarker.dart';

void main() => runApp(MaterialApp(home: MyHome()));

class MyHome extends StatelessWidget {
  const MyHome({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Flutter Demo Home Page')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => DetectMarkerView(),
            ));
          },
          child: Text('Detect Marker'),
        ),
      ),
    );
  }
}