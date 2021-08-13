import 'package:mobile/src/Pages/QuizPage/Model/QuizPageModel.dart';
import 'package:momentum/momentum.dart';

class QuizPageController extends MomentumController<QuizPageModel> {
  @override
  QuizPageModel init() {
    return QuizPageModel(
      this,
      title: '',
      description: '',
      questions: null,
    );
  }
}
