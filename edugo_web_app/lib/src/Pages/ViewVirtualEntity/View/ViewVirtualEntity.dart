import 'package:edugo_web_app/src/Components/Widgets/PageLayout.dart';
import 'package:flutter/material.dart';

class ViewVirtualEntity extends StatelessWidget {
  final String entityName;
  ViewVirtualEntity({this.entityName});
  @override
  Widget build(BuildContext context) {
    return PageLayout(child: Text("Hello"));
  }
}
