import 'package:edugo_web_app/ui/Views/subject/Model/LessonModel.dart';
import 'package:momentum/momentum.dart';

class LessonController extends MomentumController<LessonModel> {
  @override
  LessonModel init() {
    return LessonModel(this,
        lessonTitle: 'Test title 1',
        lessonDate: 'Test date 1',
        lessonDesctiprion: 'Test description 1',
        lessonID: '1');
  }

  void updateSubjectTitle(String lessonTitle) {
    model.updateSubjectTitle(lessonTitle: lessonTitle);
  }
}
