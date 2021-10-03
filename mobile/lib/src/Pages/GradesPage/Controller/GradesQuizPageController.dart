import 'package:mobile/src/Pages/GradesPage/Model/Grades.dart';
import 'package:mobile/src/Pages/GradesPage/Model/GradesQuizPageModel.dart';
import 'package:momentum/momentum.dart';

class GradesQuizPageController extends MomentumController<GradesQuizPageModel> {
  @override
  GradesQuizPageModel init() {
    return GradesQuizPageModel(this, []);
  }

  void setList(List<Quiz> quizList) {
    model.update(quizList: quizList);
  }

  List<Quiz> getList() {
    return model.quizList;
  }
}