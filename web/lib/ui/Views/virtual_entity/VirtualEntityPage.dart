import 'package:edugo_web_app/ui/widgets/EduGoPage.dart';
import 'package:flutter/material.dart';

class VirtualEntityPage extends StatelessWidget {
  final String entityName;
  VirtualEntityPage({this.entityName});
  @override
  Widget build(BuildContext context) {
    return EduGoPage(child: Text("Hello"));
  }
}
