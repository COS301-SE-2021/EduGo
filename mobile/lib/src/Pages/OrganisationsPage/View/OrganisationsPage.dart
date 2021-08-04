import 'package:flutter/material.dart';

class OrganisationsPage extends StatefulWidget {
  OrganisationsPage({Key? key}) : super(key: key);

  @override
  _OrganisationsPageState createState() => _OrganisationsPageState();
}

class _OrganisationsPageState extends State<OrganisationsPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("Toggle Organisations"),
    );
  }
}
