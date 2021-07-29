import 'package:edugo_web_app/src/Pages/EduGo.dart';

class LessonCard extends StatelessWidget {
  final String title;

  LessonCard({
    this.title,
  }) {}

  @override
  Widget build(BuildContext context) {
    //Todo: Lesson Card
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
                MomentumRouter.goto(context, UpdateLessonView);
              },
              child: Column(
                children: <Widget>[
                  //* Lesson Card Image
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(5.0),
                      topRight: Radius.circular(5.0),
                    ),
                    child: Image.asset(
                      "../assets/images/maths.jpeg",
                    ),
                  ),
                  //! Lesson Card Image
                  //* Lesson Card Title
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
                  //! End of Lesson Card Title
                ],
              ),
            ),
          ),
          //! End of Clickable Column
          //*
          //* Lesson Card Icons
          Row(
            children: [
              //* Lesson Card Delete Icon
              Padding(
                padding: const EdgeInsets.only(top: 20, bottom: 5.0),
                child: MaterialButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100)),
                  onPressed: () {},
                  child: Icon(
                    Icons.delete_outlined,
                    color: Colors.white,
                  ),
                ),
              ),
              //! End of Lesson Card Delete Icon
              Spacer(),
              //* Lesson Card Edit Icon
              Padding(
                padding: EdgeInsets.only(top: 20, bottom: 5.0),
                child: MaterialButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100)),
                  onPressed: () {},
                  child: Icon(
                    Icons.edit_outlined,
                    color: Colors.white,
                  ),
                ),
              ),
              //! End of Lesson Card Edit Icon
            ],
          ),
        ],
      ),
    );
  }
}
