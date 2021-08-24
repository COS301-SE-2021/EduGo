import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:momentum/momentum.dart';

class MockGradesPageParam extends RouterParam {
  //
  // bool <lessonId,quiz> asnwered = param passed in
}

class MockGradesPage extends StatefulWidget {
  MockGradesPage({Key? key}) : super(key: key);

  @override
  _MockGradesPageState createState() => _MockGradesPageState();
}

class _MockGradesPageState extends State<MockGradesPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: null,
    );
  }
}
