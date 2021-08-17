import 'package:edugo_web_app/src/Pages/CreateVirtualEntity/View/Widgets/CreateVirtualEntityWidgets.dart';
import 'package:edugo_web_app/src/Pages/EduGo.dart';

class QuizBuilder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MomentumBuilder(
      controllers: [CreateVirtualEntityController, QuizBuilderController],
      builder: (context, snapshot) {
        // var quizBuilder = snapshot<QuizBuilderModel>();

        return Container(
          child: Column(
            children: <Widget>[
              Material(
                elevation: 40,
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 50),
                  height: 100,
                  child: Row(
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
                ),
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
                      Momentum.controller<CreateVirtualEntityController>(
                              context)
                          .createVirtualEntity(context);
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
