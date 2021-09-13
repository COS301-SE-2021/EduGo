import 'package:edugo_web_app/src/Pages/EduGo.dart';
import 'package:edugo_web_app/src/Pages/Lessons/Model/Data/Lessons.dart';
import 'package:edugo_web_app/src/Pages/VirtualEntityStore/Model/Data/VirtualEntity.dart';

class LessonsController extends MomentumController<LessonsModel> {
  @override
  LessonsModel init() {
    return LessonsModel(this, lessonCards: [], lessons: []);
  }

// Info: Get all lessons created by the educator
  Future<void> getSubjectLessons(context) async {
    var url = Uri.parse(
        EduGoHttpModule().getBaseUrl() + '/lesson/getLessonsBySubject');
    await post(url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization':
              Momentum.controller<AdminController>(context).getToken()
        },
        body: jsonEncode(<String, int>{
          "subjectId": Momentum.controller<AdminController>(context)
              .getCurrentSubjectId()
        })).then((response) {
      if (response.statusCode == 200) {
        Map<String, dynamic> _lessons = jsonDecode(response.body);
        model.updateLessons(Lessons.fromJson(_lessons).lessons);
        model.updateLessonCards();
        return;
      }
    });
  }

  List<VirtualEntity> getLessonEntities(String id) {
    List<VirtualEntity> list = [];
    model.lessons.forEach(
      (lesson) {
        if (lesson.getLessonId().toString() == id) {
          list = lesson.getLessonEntities();
          return;
        }
      },
    );
    return list;
  }
}
