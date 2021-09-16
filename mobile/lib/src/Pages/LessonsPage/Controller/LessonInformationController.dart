import 'package:flutter/material.dart';
import 'package:mobile/src/Pages/LessonsPage/Models/LessonInformationModel.dart';
import 'package:mobile/src/Pages/VirtualEntityPage/Models/VirtualEntityModels.dart';
import 'package:momentum/momentum.dart';

class LessonInformationController
    extends MomentumController<LessonInformationModel> {
  @override
  LessonInformationModel init() {
    return LessonInformationModel(
      this,
      lessonTitle: '',
      lessonDescription: '',
      lessonID: 0,
      lessonVirtualEntities: [],
      currentVirtualEntity: new VirtualEntity(
        0,
        '',
        [],
        new Model('', ''),
      ),
      view: Row(
        children: [
          Text('No lessons'),
        ],
      ),
    );
  }

  void loadVirtualEntity(context, int VE_ID) {
    model.lessonVirtualEntities.forEach(
      (ve) {
        if (ve.id == VE_ID) {
          //setCurrentVirtualEntity(virtualEntity);
          print('virtual entity exists');
        }
      },
    );
  }

  //get the information to build the screen
  void udateLessonInformation(String lessonTitle, lessonDescription,
      int lessonID, List<VirtualEntity> virtualEntities) {
    model.update(
        lessonDescription: lessonDescription,
        lessonID: lessonID,
        lessonTitle: lessonTitle,
        lessonVirtualEntities: virtualEntities);
    buildLessonInfoView();
  }

  void buildLessonInfoView() {
    //display everything in model on screen

    /*model.lessonVirtualEntities.forEach(
      (ve) {
        VECards.add(
          new VECards(
            //id
            //thumbnail image
          ),
        );
      },
    );*/
    model.update(
      view: Row(
        children: [
          Text('view here'),
        ],
      ),
    );
  }

  void setCurrentVirtualEntity(VirtualEntity currentVirtualEntity) {
    model.update(currentVirtualEntity: currentVirtualEntity);
  }

  int getLessonId() {
    return model.lessonID;
  }

  void setLessonId(int id) {
    model.update(lessonID: id);
  }
}
