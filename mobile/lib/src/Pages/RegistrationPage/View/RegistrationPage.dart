import 'package:flutter/material.dart';
import 'package:mobile/src/Components/mobile_page_layout.dart';

class RegistrationPage extends StatelessWidget {
  const RegistrationPage();
  static String id = "registration";
/*
{   "password": "12345678",
	"user_firstName": "Sthe",
	"user_lastName": "Test",
	"user_email": "sthe@gmail.com",
	"organisation_id": "1",
	"userType": "educator", 
    "username": "sthe"
}
*/
  @override
  Widget build(BuildContext context) {
    return MobilePageLayout(true, true, Text("Mish"));
  }
}
