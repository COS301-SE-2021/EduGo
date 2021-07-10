import 'package:edugo_web_app/ui/Views/Landing/LandingPageContent.dart';
import 'package:edugo_web_app/ui/Views/Landing/LandingPageFooter.dart';
import 'package:edugo_web_app/ui/Views/Landing/LandingPageNav.dart';
import 'package:flutter/material.dart';

class EduGoHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                Color.fromRGBO(20, 195, 50, 1.0),
                Color.fromRGBO(11, 36, 54, 1.0)
              ]),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              LandingPageNav(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 60),
                child: LandingPageContent(),
              ),
              LandingPageFooter()
            ],
          ),
        ),
      ),
    );
  }
}
