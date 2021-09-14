import 'package:edugo_web_app/src/Pages/EduGo.dart';
import 'package:edugo_web_app/src/Pages/ViewLesson/Model/Data/LessonVirtualEntities.dart';
import 'package:edugo_web_app/src/Pages/ViewLesson/View/Widgets/AddEntityStoreCard.dart';
import 'package:edugo_web_app/src/Pages/VirtualEntityStore/Model/Data/VirtualEntity.dart';

class ViewLessonController extends MomentumController<ViewLessonModel> {
  @override
  ViewLessonModel init() {
    return ViewLessonModel(
      this,
      entities: [],
      lessonVirtualEntityCards: [],
    );
  }

  void viewLessonDetails(String title, String description, String id,
      List<VirtualEntity> entities) {
    model.update(lessonTitle: title);
    model.update(lessonId: id);
    model.update(lessonDescription: description);
    model.update(entities: entities);
    model.update(currentEntityImage: entities[0].getThumbNail());
    model.updateLessonVirtualEntityCards();
  }

  List<Widget> getEntities(
      {Function addFunction, Function viewFunction, String lessonId}) {
    List<Widget> lessonEntities = [];
    for (int k = 0; k < 15; k++) {
      lessonEntities.add(
        new AddEntityStoreCard(
          name: k.toString(),
          virtualEntityDescription: k.toString(),
          addFunction: addFunction,
          viewFunction: viewFunction,
          thumbNailLink: "",
        ),
      );
    }
    return lessonEntities;
  }

  void setCurrentEntityImage({String imageLink}) {
    model.update(currentEntityImage: imageLink);
  }

  String getCurrentEntityImage() {
    return model.currentEntityImage;
  }

  Future<void> addEntityToLesson(context, {String entityId}) async {
    var url = Uri.parse(
        EduGoHttpModule().getBaseUrl() + '/lesson/addVirtualEntityToLesson');
    await post(url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization':
              Momentum.controller<AdminController>(context).getToken()
        },
        body: jsonEncode(<String, int>{
          "lessonId": int.parse(model.lessonId),
          'virtualEntityId': int.parse(entityId)
        })).then((response) {
      //if (response.statusCode == 200) {

      MomentumRouter.goto(context, LessonsView);
      return;
      //}
    });
  }
}
