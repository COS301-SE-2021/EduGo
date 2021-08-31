// import 'package:mobile/src/Pages/QuizPage/Controller/QuestionPageController.dart';
// import 'package:mobile/src/Pages/QuizPage/Model/QuizModel.dart';
// import 'package:momentum/momentum.dart';

// class QuestionPageModel extends MomentumModel<QuestionPageController> {
//   QuestionPageModel(
//     QuestionPageController controller, {
//     required this.type,
//     required this.questionText,
//     required this.optionsText,
//     required this.correctAnswer,
//   }) : super(controller);

//   final QuestionType type;
//   final String questionText;
//   final List<String>? optionsText;
//   final String correctAnswer;

//   int index = 0;

//   // Every time the next button is clicked, the question of the quiz at a particular index
//   // will display. The index will be updated so when clicked again, the next question will display
//   @override
//   void update({Question? question}) {
//     QuestionPageModel(
//       controller,
//       type: question!.type,
//       questionText: question.question,
//       optionsText: question.options,
//       correctAnswer: question.correctAnswer,
//     ).updateMomentum();
//     index++;
//   }
// }

/**
 * This is the model for the GradesPage itself. 
 * The getStudentGrades endpoint will return a list of subjects.  
*/

import 'package:mobile/src/Pages/QuizPage/Controller/QuizController.dart';
import 'package:mobile/src/Pages/QuizPage/Model/Quiz.dart';
import 'package:momentum/momentum.dart';

/*------------------------------------------------------------------------------
 *             Quiz model class for the actual QuizPage
 *------------------------------------------------------------------------------
 */

//Momentum constructor
class QuizModel extends MomentumModel<QuizController> {
  QuizModel(QuizController controller, {required this.quizzes})
      : super(controller);

//List of quizzes to return
  final List<Quiz> quizzes;

  //Used by mvc momentum to update Quizsubject model
  @override
  void update({List<Quiz>? quizzes}) {
    QuizModel(controller, quizzes: quizzes ?? this.quizzes).updateMomentum();
  }
}
