import 'package:flutter/material.dart';
import 'package:momentum/momentum.dart';
import 'package:mobile/src/Pages/QuizPage/Controller/QuizzesPageController.dart';

class QuizCard extends StatelessWidget {
  final int numQuestions;
  final int id;

  const QuizCard({Key? key, required this.numQuestions, required this.id})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MomentumBuilder(
      controllers: [QuizzesPageController],
      builder: (context, snapshot) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 50.0),
          child: GestureDetector(
            onTap: () {
              Momentum.controller<QuizzesPageController>(context)
                  .answerQuiz(context, id);
            },
            child: Material(
              shadowColor: Colors.green,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              elevation: 40,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15.0),
                ),
                height: 210,
                width: 50,
                padding: EdgeInsets.symmetric(
                  vertical: 20,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Icon(
                        Icons.menu_book,
                        size: 40,
                        color: Color.fromARGB(255, 97, 211, 87),
                      ),
                    ),
                    Text(
                      'Quiz ' + id.toString(),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 28,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 85.0, vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            numQuestions.toString() + " Questions",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Color.fromARGB(255, 97, 211, 87),
                            ),
                          ),
                          Spacer(),
                          Icon(
                            Icons.arrow_forward_ios,
                            color: Color.fromARGB(255, 97, 211, 87),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
