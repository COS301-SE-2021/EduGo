import 'package:flutter/material.dart';
import 'package:momentum/momentum.dart';

class CanvasParam extends RouterParam {
  final String code;

  CanvasParam({required this.code});
}

class CanvasPage extends StatelessWidget {
  CanvasPage({Key? key, required this.code}) : super(key: key);

  final String code;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }

}