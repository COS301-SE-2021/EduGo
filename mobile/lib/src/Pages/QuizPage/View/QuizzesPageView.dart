import 'package:flutter/material.dart';
import 'package:mobile/src/Components/Nav/Bottom/View/BottomBarView.dart';
import 'package:momentum/momentum.dart';
import 'package:mobile/src/Pages/QuizPage/Controller/QuizzesPageController.dart';
import 'package:mobile/src/Pages/QuizPage/Model/QuizzesPageModel.dart';

class QuizzesPageView extends StatelessWidget {
  const QuizzesPageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MomentumBuilder(
        controllers: [QuizzesPageController],
        builder: (context, snapshot) {
          var quizzes = snapshot<QuizzesPageModel>();
          return Scaffold(
              bottomNavigationBar: new BottomBar(),
              appBar: AppBar(
                title: Row(
                  children: [
                    Icon(Icons.menu, color: Colors.white),
                    Spacer(),
                    Text(
                      "Quizzes",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
              body: ListView(
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 60),
                children: quizzes.quizzesView,
              ));
        });
  }
}
