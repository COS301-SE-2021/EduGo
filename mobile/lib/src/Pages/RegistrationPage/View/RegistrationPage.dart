import 'package:flutter/material.dart';
import 'package:mobile/src/Components/mobile_page_layout.dart';

class RegistrationPage extends StatelessWidget {
  const RegistrationPage();
  static String id = "registration";

  @override
  Widget build(BuildContext context) {
    return MobilePageLayout(true, true, Text("Mish"));
  }
}
