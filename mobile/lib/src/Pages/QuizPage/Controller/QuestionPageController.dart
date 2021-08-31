// import 'package:mobile/src/Pages/QuizPage/Model/QuestionPageModel.dart';
// import 'package:mobile/src/Pages/QuizPage/Model/QuizModel.dart';
// import 'package:momentum/momentum.dart';

// class QuestionPageController extends MomentumController<QuestionPageModel> {
//   QuestionPageController({this.mock = false});
//   bool mock;

//   // Used to get the question details in the list of questions at this index
//   late int index;

//   @override
//   QuestionPageModel init() {
//     index = -1;
//     return QuestionPageModel(
//       this,
//       type: QuestionType.TrueFalse,
//       questionText: '',
//       optionsText: [],
//       correctAnswer: '',
//     );
//   }

//   // Update the question details based on the list passed in. Move onto the
//   // next question and keep the enabled or disable at the last question.
//   bool updateQuestionDetails(List<Question>? questions) {
//     index++;
//     //print(index.toString());
//     //print(questions!.elementAt(index).type.toString());
//     // for (var q in questions) {
//     //   print(index.toString());
//     //   print(q.question);
//     //   for (var o in q.options!) {
//     //     print(o);
//     //   }
//     // }
//     //
//     if (index < questions!.length) {
//       //questions!.length;
//       model.update(question: questions.elementAt(index));
//     }
//     // last question disables 'next question' button.
//     if (index == questions.length - 1) {
//       return false;
//     }
//     return true;
//   }
// }
