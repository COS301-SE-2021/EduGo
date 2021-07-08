import 'package:edugo_web_app/ui/Views/subject/Model/SubjectModel.dart';
import 'package:momentum/momentum.dart';

class SubjectController extends MomentumController<SubjectModel> {
  @override
  SubjectModel init() {
    return SubjectModel(this,
        subjectTitle: 'Test title 1', subjectGrade: 'Test grade 1');
  }

  void updateSubjectTitle(String subjectTitle) {
    model.updateSubjectTitle(subjectTitle: subjectTitle);
  }
}
