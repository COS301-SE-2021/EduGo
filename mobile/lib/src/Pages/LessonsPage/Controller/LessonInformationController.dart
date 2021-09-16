import 'package:mobile/src/Pages/LessonsPage/View/LessonInformationPage.dart';
import 'package:momentum/momentum.dart';

class LessonInformationController
    extends MomentumController<LessonInformationPage> {
  @override
  LessonInformationPage init() {
    return LessonInformationPage(
      this,
      currentAnswer: "",
      lessonQuizzes: [],
      currentQuiz: new Quiz(
        id: 0,
        questions: [],
        lessonId: 0,
        numQuestions: 0,
      ),
      quizzesView: [],
      lessonId: 0,
      questionCount: 0,
      currentQuestion: new QuestionCard(
        questionId: 0,
        question: "",
        answerOptions: [],
      ),
    );
  }

  Future<void> getLessonQuizzes(context, int id) async {
    var prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('user_token') ?? null;

    String tk = token.toString();
    var url = Uri.parse(
        "http://edugo-backend.southafricanorth.cloudapp.azure.com:8080/virtualEntity/getQuizesByLesson");
    await post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': tk,
      },
      body: jsonEncode(
        <String, int>{
          "id": id,
        },
      ),
    ).then(
      (response) {
        if (response.statusCode == 200) {
          setLessonId(id);
          dynamic _quizzes = jsonDecode(response.body);
          model.update(lessonQuizzes: Quizzes.fromJson(_quizzes, id).quizzes);
          buildQuizzesView();
          MomentumRouter.goto(context, QuizzesPageView);
          return;
        }
      },
    );
  }

  Future<void> completeQuiz(context) async {
    var prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('user_token') ?? null;

    String tk = token.toString();

    var url = Uri.parse(
        "http://edugo-backend.southafricanorth.cloudapp.azure.com:8080/virtualEntity/answerQuiz");
    await post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': tk,
      },
      body: jsonEncode(
        <String, dynamic>{
          "lesson_id": model.lessonId,
          "quiz_id": model.currentQuiz.getId(),
          "answers": model.currentQuiz.getAnswersJson(),
        },
      ),
    ).then(
      (response) {
        if (response.statusCode == 200) {
          int tempId = model.lessonId;
          reset();
          model.update(lessonId: tempId);
          getLessonQuizzes(context, model.lessonId);

          return;
        }
      },
    );
  }

  void answerQuiz(context, int id) {
    model.lessonQuizzes.forEach(
      (quiz) {
        if (quiz.getId() == id) {
          resetQuestionCount();
          setCurrentQuiz(quiz);
          setCurrentQuestionCard();
          MomentumRouter.goto(context, QuizPageView);
        }
      },
    );
  }

  void updateLessonQuizzes(List<Quiz> quizzes) {
    model.update(lessonQuizzes: quizzes);
    buildQuizzesView();
  }

  void buildQuizzesView() {
    List<Widget> quizCards = [];
    model.lessonQuizzes.forEach(
      (quiz) {
        quizCards.add(
          new QuizCard(
            numQuestions: quiz.getNumQuestions(),
            id: quiz.getId(),
          ),
        );
      },
    );
    model.update(quizzesView: quizCards);
  }

  void setCurrentQuiz(Quiz currentQuiz) {
    model.update(currentQuiz: currentQuiz);
  }

  void setLessonId(int id) {
    model.update(lessonId: id);
  }

  void resetQuestionCount() {
    model.update(questionCount: 0);
  }

  String getInitialOption() {
    return model.currentQuiz
        .getQuestions()[model.questionCount]
        .getAnswerOptions()[0];
  }

  void nextQuestion() {
    int tempCount = model.questionCount;
    tempCount++;
    model.update(questionCount: tempCount);
  }

  void answerQuestion(context) {
    if (model.currentAnswer.isNotEmpty &&
        model.questionCount < model.currentQuiz.getNumQuestions() - 1) {
      model.currentQuiz
          .getQuestions()[model.questionCount]
          .setGivenAnswer(model.currentAnswer);
      model.update(currentAnswer: "");
      nextQuestion();
      setCurrentQuestionCard();
    } else if (model.questionCount == model.currentQuiz.getNumQuestions() - 1) {
      model.currentQuiz
          .getQuestions()[model.questionCount]
          .setGivenAnswer(model.currentAnswer);

      MomentumRouter.goto(context, QuizCompletedView);
    }
  }

  void setCurrentQuestionCard() {
    Question question = model.currentQuiz.getQuestions()[model.questionCount];
    QuestionCard questionCard = new QuestionCard(
      questionId: question.getId(),
      question: question.getQuestion(),
      answerOptions: question.getAnswerOptions(),
    );
    model.update(currentQuestion: questionCard);
  }

  void chooseAnswer(String answer) {
    model.update(currentAnswer: answer);
  }

  int getLessonId() {
    return model.lessonId;
  }
}
