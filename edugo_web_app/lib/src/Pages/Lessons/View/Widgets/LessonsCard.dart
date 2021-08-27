import 'package:edugo_web_app/src/Pages/EduGo.dart';

class LessonsCard extends StatelessWidget {
  final String title;
  final int id;

  LessonsCard({this.title, this.id});

  @override
  Widget build(BuildContext context) {
    //Todo: Lesson Card
    return Container(
      margin: EdgeInsets.only(bottom: 50),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 70.0),
        child: Card(
          elevation: 50,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
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
                  padding: const EdgeInsets.all(20.0),
                  child: Image.asset(
                    "../assets/images/maths.jpeg",
                    height: 100,
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
                    //* Lesson Card Delete Icon
                    MaterialButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100)),
                      onPressed: () {},
                      child: Icon(
                        Icons.delete_outlined,
                        color: Color.fromARGB(255, 97, 211, 87),
                        size: 35,
                      ),
                    ),
                    //! End of Lesson Card Delete Icon

                    //* Lesson Card Edit Icon
                    MaterialButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100)),
                      onPressed: () {
                        MomentumRouter.goto(context, ViewLesson);
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
  }
}
