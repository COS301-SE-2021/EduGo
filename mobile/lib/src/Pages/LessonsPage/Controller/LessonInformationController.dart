import 'package:flutter/material.dart';
import 'package:mobile/src/Pages/DetectMarkerPage/View/DetectMarkerPage.dart';
import 'package:mobile/src/Pages/LessonsPage/Models/LessonInformationModel.dart';
import 'package:mobile/src/Pages/LessonsPage/View/LessonInformationPage.dart';
import 'package:mobile/src/Pages/QuizPage/Controller/QuizzesPageController.dart';
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
          Text('No lesson'),
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

  // Load thumbnails
  List<Widget> _mockImages(
      int noOfThumbnails, List<VirtualEntity> lessonVirtualEntities) {
    List<Widget> imagesAndCaptions = [];

    for (int i = 0; i < noOfThumbnails; i++) {
      imagesAndCaptions.add(
        Expanded(
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            Material(
              shape: CircleBorder(),
              elevation: 3.0,
              child: Image.network(
                //Mobile app: child: Image.asset(
                lessonVirtualEntities.elementAt(i).model!.thumbnail,
                fit: BoxFit.fill,
                height: 80,
                width: 100,
              ),
            ),
            Expanded(
              child: FittedBox(
                child: Text(
                  'id: ' + lessonVirtualEntities.elementAt(i).id.toString(),
                  style: TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ]),
        ),
      );
    }
    return imagesAndCaptions;
  }

  Widget getView(context, String lessonTitle, String lessonDescription,
      int lessonID, List<VirtualEntity> lessonVirtualEntities) {
    return Container(
      //decoration: BoxDecoration(border: Border.all(color: Colors.red)),
      //child: SingleChildScrollView(
      child: ListView(
          padding: EdgeInsets.only(top: 50, bottom: 100, left: 40, right: 40),
          children: [
            Column(
              //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                //Lesson title, aligned top left. Button leading to Quiz top right
                new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      //lesson title
                      new Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          lessonTitle,
                          style: TextStyle(
                            fontSize: 25,
                          ),
                        ),
                      ),
                      //Quizzes button
                      new Align(
                        alignment: Alignment.topRight,
                        child: MaterialButton(
                          elevation: 20,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                          onPressed: () {
                            Momentum.controller<QuizzesPageController>(context)
                                .getLessonQuizzes(context, lessonID);
                          },
                          minWidth: 10,
                          height: 25,
                          color: Color.fromARGB(255, 97, 211, 87),
                          disabledColor: Color.fromRGBO(211, 212, 217, 1),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: <Widget>[
                                Icon(
                                  Icons.post_add,
                                  color: Colors.white,
                                  size: 20,
                                ),
                                Text(
                                  "Quizzes",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ]),
                //Lesson description
                new Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 25),
                    child: Text(
                      lessonDescription,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 10,
                      softWrap: true,
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                  ),
                ),
                //Scan QR code
                Padding(
                  padding: const EdgeInsets.only(top: 15.0, bottom: 8.0),
                  child: MaterialButton(
                      elevation: 20,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      onPressed: () {
                        MomentumRouter.goto(
                          context,
                          DetectMarkerPage,
                          transition: (context, page) {
                            return MaterialPageRoute(
                                builder: (context) => page);
                          },
                        );
                      },
                      minWidth: 10,
                      height: 25,
                      color: Color.fromARGB(255, 97, 211, 87),
                      disabledColor: Color.fromRGBO(211, 212, 217, 1),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: <Widget>[
                            Icon(
                              Icons.qr_code,
                              color: Colors.white,
                              size: 20,
                            ),
                            Text(
                              "Scan QR code ",
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      )),
                ),

                //Virtual entities display:
                //the number of tabs represent the no of virual entity
                // each virtual entity is labeled by it's id
                GridView.count(
                  shrinkWrap: true,
                  crossAxisCount: 3,
                  children: _mockImages(
                      lessonVirtualEntities.length, lessonVirtualEntities),
                ),
              ],
            ),
          ]),
    );
  }

  //get the information to build the screen
  void updateLessonInformation(context, String lessonTitle, lessonDescription,
      int lessonID, List<VirtualEntity> lessonVirtualEntities) {
    print('lesson page');
    model.update(
      lessonDescription: lessonDescription,
      lessonID: lessonID,
      lessonTitle: lessonTitle,
      lessonVirtualEntities: lessonVirtualEntities,
      view: getView(context, lessonTitle, lessonDescription, lessonID,
          lessonVirtualEntities),
    );
    //buildLessonInfoView();
    MomentumRouter.goto(context, LessonInformationPage);
  }
}
