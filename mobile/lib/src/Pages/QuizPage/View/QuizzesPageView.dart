import 'package:flutter/material.dart';
import 'package:mobile/src/Components/Nav/Bottom/View/BottomBarView.dart';
import 'package:mobile/src/Components/mobile_page_layout.dart';
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

          Widget child = ListView(
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 60),
            children: quizzes.quizzesView,
          );
          return MobilePageLayout(false, true, child, 'Quizzes');
        });
  }
}
