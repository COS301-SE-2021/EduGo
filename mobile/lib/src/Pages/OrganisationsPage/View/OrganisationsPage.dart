import 'package:flutter/material.dart';
import 'package:mobile/src/Components/mobile_page_layout.dart';

class OrganisationsPage extends StatefulWidget {
  OrganisationsPage({Key? key}) : super(key: key);
  static String id = "organisations";
  @override
  _OrganisationsPageState createState() => _OrganisationsPageState();
}

class _OrganisationsPageState extends State<OrganisationsPage> {
  @override
  Widget build(BuildContext context) {
    return MobilePageLayout(
      true,
      true,
      false,
      Container(child: Text("org")),
      'Organisations',
    );
  }
}
