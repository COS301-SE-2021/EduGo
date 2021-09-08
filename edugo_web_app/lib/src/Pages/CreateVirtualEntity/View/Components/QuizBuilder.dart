import 'package:edugo_web_app/src/Pages/CreateVirtualEntity/View/Widgets/CreateVirtualEntityWidgets.dart';
import 'package:edugo_web_app/src/Pages/EduGo.dart';

class QuizBuilder extends StatelessWidget {
  final GlobalKey<FormState> createQuizFormKey;

  const QuizBuilder({Key key, this.createQuizFormKey}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MomentumBuilder(
      controllers: [CreateVirtualEntityController, QuizBuilderController],
      builder: (context, snapshot) {
        // var quizBuilder = snapshot<QuizBuilderModel>();
        Momentum.controller<QuizBuilderController>(context)
            .setFormKey(createQuizFormKey);
        return Container(
          child: Column(
            children: <Widget>[
              Material(
                elevation: 40,
                shadowColor: Colors.green,
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
              Form(
                key: createQuizFormKey,
                child: Column(
                  children: Momentum.controller<QuizBuilderController>(context)
                      .buildQuizBuilderView(),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
