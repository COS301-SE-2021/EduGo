import 'package:flutter/material.dart';
import 'package:mobile/src/Pages/QuizPage/Controller/QuizzesPageController.dart';
import 'package:momentum/momentum.dart';

class QuizCompletedView extends StatelessWidget {
  const QuizCompletedView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15.0),
        ),
        width: 400,
        padding: EdgeInsets.symmetric(
          vertical: 20,
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 50),
                child: Icon(
                  Icons.bookmark_added,
                  size: 60,
                  color: Color.fromARGB(255, 97, 211, 87),
                ),
              ),
              Text(
                'Quiz Completed',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 32,
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 85.0, vertical: 50),
                child: Text(
                  "Grade will be available soon in Grades Center.",
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.visible,
                  softWrap: true,
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 85.0, vertical: 10),
                child: MaterialButton(
                  height: 50,
                  padding: EdgeInsets.symmetric(
                    horizontal: 40,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  elevation: 40,
                  color: Color.fromARGB(255, 97, 211, 87),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Done",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                        ),
                      ),
                      Spacer(),
                      Icon(
                        Icons.done,
                        color: Colors.white,
                      ),
                    ],
                  ),
                  onPressed: () {
                    Momentum.controller<QuizzesPageController>(context)
                        .completeQuiz(context);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
