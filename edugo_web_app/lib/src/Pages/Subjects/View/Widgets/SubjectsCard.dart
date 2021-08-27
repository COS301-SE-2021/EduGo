import 'package:edugo_web_app/src/Pages/EduGo.dart';

class SubjectsCard extends StatelessWidget {
  //Info: Subjects card attributes
  final String title;
  final String grade;
  final int subjectId;
  final String imageLink;

  SubjectsCard({this.title, this.grade, this.subjectId, this.imageLink});

  @override
  Widget build(BuildContext context) {
    //Info: Subjects card user interface
    return Card(
      elevation: 40,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
      shadowColor: Colors.white,
      color: Color.fromARGB(255, 97, 211, 87),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          //* Clickable Column
          MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: () {
                //Info: set current subject Id to card's subect ID
                Momentum.controller<AdminController>(context)
                    .setCurrentSubjectId(this.subjectId);

                //Info: redirect to lessons view
                MomentumRouter.goto(context, LessonsView);
              },
              child: Column(
                children: <Widget>[
                  //* Subject Card Image
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(5.0),
                      topRight: Radius.circular(5.0),
                    ),
                    child: Image.asset(
                      //Todo: repace with this.imagelink
                      "../assets/images/maths.jpeg",
                    ),
                  ),
                  //! Subject Card Image
                  //* Subject Card Title
                  Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      title,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      softWrap: false,
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                  //! End of Subject Card Image
                  //* Subject Card Grade
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Text(
                      "Grade: " + grade,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      softWrap: false,
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                  //! End of Subject Card Grade
                ],
              ),
            ),
          ),
          //! End of Clickable Column
          //*
          //* Subject Card Icons
          Row(
            children: [
              //* Subject Card Delete Icon
              Padding(
                padding: const EdgeInsets.only(top: 20, bottom: 5.0),
                child: MaterialButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100)),
                  onPressed: () {
                    // Todo: make delete api request
                  },
                  child: Icon(
                    Icons.delete_outlined,
                    color: Colors.white,
                  ),
                ),
              ),
              //! End of Subject Card Delete Icon
              Spacer(),
              //* Subject Card Edit Icon
              Padding(
                padding: EdgeInsets.only(top: 20, bottom: 5.0),
                child: MaterialButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100)),
                  onPressed: () {
                    MomentumRouter.goto(context, LessonsView);
                  },
                  child: Icon(
                    Icons.auto_stories_outlined,
                    color: Colors.white,
                  ),
                ),
              ),
              //! End of Subject Card Edit Icon
            ],
          ),
        ],
      ),
    );
  }
}
