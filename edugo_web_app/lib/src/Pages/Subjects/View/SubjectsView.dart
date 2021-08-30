import 'package:edugo_web_app/src/Pages/EduGo.dart';
import 'package:edugo_web_app/src/Pages/Subjects/View/Widgets/SubjectsWidgets.dart';

class SubjectsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //Info: Getting educator subject from API
    Momentum.controller<SubjectsController>(context)
        .getEducatorSubjects(context);

    //Info: Buiding subjects user interface
    return MomentumBuilder(
      controllers: [SubjectsController],
      builder: (context, snapshot) {
        //Info: reading subject cards from model
        var educatorSubjects = snapshot<SubjectsModel>();

        Future<String> subjectsLoaded = Future<String>.delayed(
          const Duration(seconds: 0),
          () {
            if (educatorSubjects.subjectCards.isEmpty) return null;
            return "Data loaded";
          },
        );

        //Info: rendering subject cards
        return PageLayout(
          top: 0,
          left: 0,
          right: 0,
          child: Stack(
            children: [
              FutureBuilder(
                future: subjectsLoaded,
                builder:
                    (BuildContext context, AsyncSnapshot<String> snapshot) {
                  if (snapshot.hasData)
                    return Container(
                      padding: EdgeInsets.only(top: 0),
                      child: ListView(
                        padding: EdgeInsets.only(
                          top: 0,
                        ),
                        children: <Widget>[
                          StickyHeader(
                            header: Material(
                              elevation: 40,
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                padding: EdgeInsets.only(
                                    right: 50, left: 100, top: 25, bottom: 25),
                                child: Column(
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Text(
                                          "Created Subjects",
                                          style: TextStyle(
                                            fontSize: 32,
                                          ),
                                        ),
                                        Spacer(),
                                        SubjectsButton(
                                          onPressed: () {
                                            MomentumRouter.goto(
                                                context, CreateSubjectView);
                                          },
                                          child: Row(
                                            children: <Widget>[
                                              Icon(
                                                Icons.add,
                                                color: Colors.white,
                                              ),
                                              SizedBox(width: 20),
                                              Text(
                                                "Create Subject",
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
                                    )
                                  ],
                                ),
                              ),
                            ),
                            content: GridView.count(
                              physics: NeverScrollableScrollPhysics(),
                              primary: false,
                              shrinkWrap: true,
                              padding: const EdgeInsets.only(
                                  right: 30, left: 30, top: 40, bottom: 80),
                              crossAxisSpacing: 40,
                              mainAxisSpacing: 40,
                              crossAxisCount: 4,
                              childAspectRatio: 1 / 1.1,
                              children: educatorSubjects.subjectCards,
                            ),
                          ),
                        ],
                      ),
                    );
                  return Scaffold(
                    body: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 100,
                            width: 100,
                            child: CircularProgressIndicator(
                              valueColor: new AlwaysStoppedAnimation<Color>(
                                  Color.fromARGB(255, 97, 211, 87)),
                            ),
                          ),
                          SizedBox(
                            height: 50,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "Packing ",
                                style: TextStyle(fontSize: 28),
                              ),
                              Text(
                                "Book",
                                style: TextStyle(
                                    color: Color.fromARGB(255, 97, 211, 87),
                                    fontSize: 28),
                              ),
                              Text(
                                "Shelf...",
                                style: TextStyle(fontSize: 28),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
