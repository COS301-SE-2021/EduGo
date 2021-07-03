import 'package:edugo_web_app/src/Pages/Home/View/Components/Footer/HomeFooter.dart';
import 'package:edugo_web_app/src/Pages/Home/View/Components/Navigation/HomeNavigation.dart';
import 'package:flutter/material.dart';

import 'Components/Content.dart';

class Home extends StatelessWidget {
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
              HomeNavigation(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 60),
                child: Content(),
              ),
              HomeFooter()
            ],
          ),
        ),
      ),
    );
  }
}
