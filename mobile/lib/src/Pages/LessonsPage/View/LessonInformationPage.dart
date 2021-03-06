import 'package:flutter/material.dart';
import 'package:mobile/src/Components/mobile_page_layout.dart';
import 'package:mobile/src/Pages/DetectMarkerPage/View/DetectMarkerPage.dart';
import 'package:mobile/src/Pages/LessonsPage/Controller/LessonInformationController.dart';
import 'package:mobile/src/Pages/LessonsPage/Models/LessonInformationModel.dart';
import 'package:mobile/src/Pages/QuizPage/Controller/QuizzesPageController.dart';
import 'package:mobile/src/Pages/VirtualEntityPage/Models/VirtualEntityModels.dart';
import 'package:mobile/src/Pages/VirtualEntityPage/View/ARWindow.dart';
import 'package:mobile/src/Pages/VirtualEntityPage/View/VirtualEntityPage.dart';
import 'package:momentum/momentum.dart';

class LessonInformationPage extends StatefulWidget {
  LessonInformationPage({Key? key}) : super(key: key);

  @override
  _LessonInformationPageState createState() => _LessonInformationPageState();
}

class _LessonInformationPageState extends State<LessonInformationPage> {
  @override
  Widget build(BuildContext context) {
    MomentumBuilder child = MomentumBuilder(
        controllers: [LessonInformationController, QuizzesPageController],
        builder: (context, snapshot) {
          var info = snapshot<LessonInformationModel>();
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
                          'id: ' +
                              lessonVirtualEntities.elementAt(i).id.toString(),
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

          return Container(
            //decoration: BoxDecoration(border: Border.all(color: Colors.red)),
            //child: SingleChildScrollView(
            child: ListView(
                padding:
                    EdgeInsets.only(top: 50, bottom: 100, left: 40, right: 40),
                children: [
                  Column(
                    //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      //Lesson title, aligned top left.

                      //lesson title
                      new Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          info.lessonTitle,
                          style: TextStyle(
                            fontSize: 25,
                          ),
                        ),
                      ),

                      //Lesson description
                      new Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 25),
                          child: Text(
                            info.lessonDescription,
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
                      new Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            //Go to virtual entity
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 15.0, bottom: 8.0),
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
                                    VirtualEntityView,
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
                                        Icons.view_in_ar,
                                        color: Colors.white,
                                        size: 20,
                                      ),
                                      Text(
                                        "AR",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            //Quizzes button
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 15.0, bottom: 8.0),
                              child: MaterialButton(
                                elevation: 20,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                ),
                                onPressed: () {
                                  Momentum.controller<QuizzesPageController>(
                                          context)
                                      .getLessonQuizzes(context, info.lessonID);
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
                      //Virtual entities display:
                      //the number of tabs represent the no of virual entity
                      // each virtual entity is labeled by it's id
                      GridView.count(
                        shrinkWrap: true,
                        crossAxisCount: 3,
                        children: _mockImages(info.lessonVirtualEntities.length,
                            info.lessonVirtualEntities),
                      ),
                    ],
                  ),
                ]),
          );
        });
    return MobilePageLayout(false, true, false, child, 'LessonInfo');
  }
}
