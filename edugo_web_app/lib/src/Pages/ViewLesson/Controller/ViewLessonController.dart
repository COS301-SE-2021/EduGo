import 'package:edugo_web_app/src/Pages/EduGo.dart';
import 'package:edugo_web_app/src/Pages/ViewLesson/View/Widgets/ViewLessonWidgets.dart';
import 'package:edugo_web_app/src/Pages/VirtualEntityStore/Model/Data/VirtualEntity.dart';

class ViewLessonController extends MomentumController<ViewLessonModel> {
  @override
  ViewLessonModel init() {
    return ViewLessonModel(this,
        entities: [], lessonVirtualEntityCards: [], responseString: "init");
  }

  void viewLessonDetails(String title, String description, String id,
      List<VirtualEntity> entities) {
    model.update(lessonTitle: title);
    model.update(lessonId: id);
    model.update(lessonDescription: description);
    model.update(entities: entities);
    model.update(
        currentEntityImage: entities.isEmpty ? '' : entities[0].getThumbNail());
    model.update(currentModel: entities.isEmpty ? '' : entities[0].getModel());
    updateLessonVirtualEntityCards();
  }

  void setCurrentEntityImage({String imageLink}) {
    model.update(currentEntityImage: imageLink);
  }

// Info: Update lesson virtual entity cards
  void updateLessonVirtualEntityCards() {
    List<Widget> lessonVirtualEntityCardsUpdate = [];
    model.entities.forEach(
      (entity) {
        lessonVirtualEntityCardsUpdate.add(
          new VirtualEntitySelectorCard(
            title: entity.getVirtualEntityName(),
            link: entity.getThumbNail(),
          ),
        );
      },
    );
    if (lessonVirtualEntityCardsUpdate.isEmpty) {
      lessonVirtualEntityCardsUpdate.add(
        Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 30),
                child: Icon(
                  Icons.view_in_ar_outlined,
                  size: 60,
                  color: Color.fromARGB(255, 97, 211, 87),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "No Ent",
                    style: TextStyle(
                      fontSize: 25,
                    ),
                  ),
                  Text(
                    "ities",
                    style: TextStyle(
                      fontSize: 25,
                      color: Color.fromARGB(255, 97, 211, 87),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      );
    }
    model.update(
        currentEntityImage:
            model.entities.isEmpty ? '' : model.entities[0].getThumbNail());
    model.update(lessonVirtualEntityCards: lessonVirtualEntityCardsUpdate);
  }

  int getEntityId() {
    int k = 0;
    model.entities.forEach(
      (entity) {
        if (entity.getThumbNail() == model.currentEntityImage) {
          k = entity.getVirtualEntityId();
          return k;
        }
      },
    );
    return k;
  }

  String getCurrentEntityImage() {
    return model.currentEntityImage;
  }

  Future<String> addEntityToLesson(context,
      {String entityId,
      bool addViewLoadController,
      bool addStoreLoadController}) async {
    model.update(responseString: "");
    if (addViewLoadController == true) {
      model.update(addViewLoadController: false);
    }
    if (addStoreLoadController == true) {
      model.update(addStoreLoadController: false);
    }
    var url = Uri.parse(
        EduGoHttpModule().getBaseUrl() + '/lesson/addVirtualEntityToLesson');
    await post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization':
            Momentum.controller<AdminController>(context).getToken()
      },
      body: jsonEncode(
        <String, int>{
          "lessonId": int.parse(model.lessonId),
          'virtualEntityId': int.parse(entityId)
        },
      ),
    ).then(
      (response) {
        if (response.statusCode == 200) {
          if (addViewLoadController == false) {
            model.update(addViewLoadController: true);
          }
          if (addStoreLoadController == false) {
            model.update(addStoreLoadController: true);
          }
          model.update(responseString: "Entity Added");
          return;
        } else {
          if (addViewLoadController == false) {
            model.update(addViewLoadController: true);
          }
          if (addStoreLoadController == false) {
            model.update(addStoreLoadController: true);
          }
          model.update(responseString: "Entity Not Added");
          return;
        }
      },
    );
    return model.responseString;
  }

  void addVirtualEntityLoadControllerReset() {
    model.update(addViewLoadController: true);
  }
}
