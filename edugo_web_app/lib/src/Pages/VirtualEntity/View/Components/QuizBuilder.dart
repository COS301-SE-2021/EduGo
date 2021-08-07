import 'package:edugo_web_app/src/Pages/EduGo.dart';

class QuizBuilder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MomentumBuilder(
      controllers: [VirtualEntityApiController, QuizBuilderController],
      builder: (context, snapshot) {
        var quizBuilder = snapshot<QuizBuilderModel>();

        return Container(
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Quiz",
                    style: TextStyle(fontSize: 32),
                  ),
                  Text(
                    "Builder",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 32,
                      color: Color.fromARGB(255, 97, 211, 87),
                    ),
                  ),
                  Spacer(),
                  VirtualEntityButton(
                      elevation: 40,
                      child: Text(
                        "New Question",
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        Momentum.controller<QuizBuilderController>(context)
                            .newQuestion();
                      },
                      width: 200,
                      height: 50),
                ],
              ),
              SizedBox(
                height: 50,
              ),
              Column(
                children: Momentum.controller<QuizBuilderController>(context)
                    .buildQuizBuilderView(),
              ),
              SizedBox(
                height: 40,
              ),
              VirtualEntityButton(
                  elevation: 40,
                  child: Text(
                    "Create Virtual Entity",
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    if (Momentum.controller<QuizBuilderController>(context)
                            .getQuizBuilderResult() !=
                        "Quiz is not valid") {
                      MomentumRouter.goto(context, EducatorVirtualEntitiesView);
                    }
                  },
                  width: 450,
                  height: 65),
            ],
          ),
        );
      },
    );
  }
}
