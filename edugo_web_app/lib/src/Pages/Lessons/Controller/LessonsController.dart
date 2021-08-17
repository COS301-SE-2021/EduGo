import 'package:edugo_web_app/src/Pages/EduGo.dart';
import 'package:edugo_web_app/src/Pages/Lessons/Model/Data/Lessons.dart';

class LessonsController extends MomentumController<LessonsModel> {
  @override
  LessonsModel init() {
    return LessonsModel(this, lessonCards: [], lessons: []);
  }

// Info: Get all lessons created by the educator
  Future<void> getSubjectLessons(context) async {
    var url =
        Uri.parse('http://43e6071f3a8e.ngrok.io/lesson/getLessonsBySubject');
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
        return;
      }
    });
  }
}
