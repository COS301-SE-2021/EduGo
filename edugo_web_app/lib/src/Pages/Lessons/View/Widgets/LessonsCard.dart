import 'package:edugo_web_app/src/Pages/EduGo.dart';

class LessonsCard extends StatelessWidget {
  final String title;
  final int id;
  final String description;

  LessonsCard({this.title, this.id, this.description});

  @override
  Widget build(BuildContext context) {
    //Todo: Lesson Card
    return MomentumBuilder(
        controllers: [LessonsController],
        builder: (context, snapshot) {
          var lesson = snapshot<LessonsModel>();
          return Container(
            margin: EdgeInsets.only(bottom: 50),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50.0),
              child: Card(
                elevation: 50,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                shadowColor: Color.fromARGB(255, 97, 211, 87),
                color: Colors.white,
                child: Row(
                  children: <Widget>[
                    //* Lesson Card Image
                    ClipRRect(
                      borderRadius: BorderRadius.all(
                        Radius.circular(5.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 20.0,
                        ),
                        child: Image.network(
                          Momentum.controller<AdminController>(context)
                              .getCurrentSubjectImage(),
                          width: 400,
                          height: 110,
                        ),
                      ),
                    ),
                    //! Lesson Card Image
                    //* Lesson Card Title
                    Spacer(),
                    Container(
                      child: Column(children: [
                        Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Text(
                            title,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            softWrap: false,
                            style: TextStyle(
                              fontSize: 25,
                            ),
                          ),
                        ),
                        //*
                      ]),
                    ),
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(right: 30.0),
                      child: Row(
                        children: [
                          //* Lesson Card Edit Icon
                          MaterialButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(100)),
                            onPressed: () {
                              Momentum.controller<ViewLessonController>(context)
                                  .viewLessonDetails(
                                title,
                                description,
                                id.toString(),
                                Momentum.controller<LessonsController>(context)
                                    .getLessonEntities(
                                  id.toString(),
                                ),
                              );
                              MomentumRouter.goto(context, ViewLessonView);
                            },
                            child: Icon(
                              Icons.edit_outlined,
                              color: Color.fromARGB(255, 97, 211, 87),
                              size: 35,
                            ),
                          ),
                          //! End of Lesson Card Edit Icon
                        ],
                      ),
                    ),
                    //! End of Lesson Card Title
                  ],
                ),
              ),
            ),
          );
        });
  }
}
