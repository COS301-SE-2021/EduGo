import 'package:edugo_web_app/src/Pages/CreateVirtualEntity/View/Widgets/CreateVirtualEntityWidgets.dart';
import 'package:edugo_web_app/src/Pages/EduGo.dart';
import 'package:edugo_web_app/src/Pages/Lessons/View/Widgets/LessonsWidgets.dart';
import 'package:edugo_web_app/src/Pages/ViewLesson/View/Widgets/ViewLessonWidgets.dart';

class ViewLessonView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //Info: Getting lesson information from API

    //Info: Buiding lesson display interface
    return MomentumBuilder(
        controllers: [ViewLessonController],
        builder: (context, snapshot) {
          var viewLesson = snapshot<ViewLessonModel>();

          //Info: rendering lesson display
          return PageLayout(
            top: 0,
            left: 0,
            right: 0,
            child: Stack(
              children: [
                Container(
                  padding: EdgeInsets.only(top: 0),
                  child: ListView(
                    primary: false,
                    shrinkWrap: true,
                    padding: const EdgeInsets.only(
                        right: 70, left: 70, top: 50, bottom: 80),
                    children: [
                      Material(
                        borderRadius: BorderRadius.circular(8),
                        elevation: 40,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: EdgeInsets.only(
                              right: 50, left: 50, top: 50, bottom: 70),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    viewLesson.lessonTitle,
                                    style: TextStyle(
                                      fontSize: 32,
                                    ),
                                  ),
                                  Spacer(),
                                  LessonsButton(
                                    onPressed: () {
                                      MomentumRouter.goto(context, LessonsView);
                                    },
                                    child: Row(
                                      children: <Widget>[
                                        Icon(
                                          Icons.arrow_back,
                                          color: Colors.white,
                                        ),
                                        SizedBox(width: 20),
                                        Text(
                                          "Back",
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                    width: 250,
                                    height: 60,
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 50,
                              ),
                              Material(
                                elevation: 40,
                                borderRadius: BorderRadius.circular(12),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  padding: EdgeInsets.only(
                                      right: 25, left: 25, top: 25, bottom: 25),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            "Des",
                                            style: TextStyle(
                                                fontSize: 32,
                                                color: Color.fromARGB(
                                                    255, 97, 211, 87)),
                                          ),
                                          Text(
                                            "cription",
                                            style: TextStyle(
                                              fontSize: 32,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Text(viewLesson.lessonDescription),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 50,
                              ),
                              Material(
                                elevation: 40,
                                borderRadius: BorderRadius.circular(12),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  padding: EdgeInsets.only(
                                      right: 50, left: 50, top: 25, bottom: 50),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            "Virtual",
                                            style: TextStyle(fontSize: 32),
                                          ),
                                          Text(
                                            " Entities",
                                            style: TextStyle(
                                              fontSize: 32,
                                              color: Color.fromARGB(
                                                  255, 97, 211, 87),
                                            ),
                                          ),
                                          Spacer(),
                                          Flexible(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Row(
                                                children: [
                                                  MouseRegion(
                                                    cursor: SystemMouseCursors
                                                        .click,
                                                    child: GestureDetector(
                                                      child: Icon(
                                                        Icons.computer_outlined,
                                                        size: 50,
                                                        color: Color.fromARGB(
                                                            255, 97, 211, 87),
                                                      ),
                                                      onTap: () {
                                                        Momentum.controller<
                                                                    CanvasController>(
                                                                context)
                                                            .getCanvasView(
                                                          context,
                                                          Momentum.controller<
                                                                      ViewLessonController>(
                                                                  context)
                                                              .getEntityId()
                                                              .toString(),
                                                        );
                                                      },
                                                    ),
                                                  ),
                                                  Spacer(),
                                                  VirtualEntityButton(
                                                      child: Text(
                                                        "Print Marker",
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
                                                      ),
                                                      onPressed: () async {
                                                        final image =
                                                            await QrPainter(
                                                          data: 'EduGo_Marker {"ve_id":' +
                                                              Momentum.controller<
                                                                          ViewLessonController>(
                                                                      context)
                                                                  .getEntityId()
                                                                  .toString() +
                                                              '}',
                                                          version:
                                                              QrVersions.auto,
                                                          errorCorrectionLevel:
                                                              QrErrorCorrectLevel
                                                                  .Q,
                                                        ).toImageData(400);

                                                        var pngBytes = image
                                                            .buffer
                                                            .asUint8List();
                                                        var download = document
                                                                .createElement(
                                                                    'a')
                                                            as AnchorElement;

                                                        download.href =
                                                            'data:image/png;base64,' +
                                                                base64Encode(
                                                                    pngBytes);
                                                        download.download = 'VE_' +
                                                            Momentum.controller<
                                                                        ViewLessonController>(
                                                                    context)
                                                                .getEntityId()
                                                                .toString() +
                                                            '_EduGo_3D_Model.png';

                                                        download.click();

                                                        download.remove();
                                                      },
                                                      width: 200,
                                                      height: 60),
                                                  Spacer(),
                                                  LessonsButton(
                                                    onPressed: () {
                                                      MomentumRouter.goto(
                                                          context,
                                                          AddEntityStore);
                                                    },
                                                    child: Row(
                                                      children: <Widget>[
                                                        Icon(
                                                          Icons
                                                              .view_in_ar_outlined,
                                                          color: Colors.white,
                                                        ),
                                                        SizedBox(width: 20),
                                                        Text(
                                                          "Add Virtual Entity",
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    width: 200,
                                                    height: 60,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 50,
                                      ),
                                      Row(
                                        children: <Widget>[
                                          Flexible(
                                            child: Column(
                                                children: viewLesson
                                                    .lessonVirtualEntityCards),
                                          ),
                                          Spacer(),
                                          ViewLessonVirtualEntityModelViewer()
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }
}
