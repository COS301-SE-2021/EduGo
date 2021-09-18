import 'package:edugo_web_app/src/Pages/EduGo.dart';

class StudentsGradesCard extends StatelessWidget {
  final String name;
  final double grade;
  final Color _color = RandomColor().randomColor();
  StudentsGradesCard({this.name, this.grade});

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
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
          shadowColor: Color.fromARGB(255, 97, 211, 87),
          color: Colors.white,
          child: Row(
            children: <Widget>[
              //* Lesson Card Image
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: AvatarLetter(
                  size: 100,
                  backgroundColor: _color,
                  textColor: Colors.black,
                  fontSize: 50,
                  numberLetters: 1,
                  letterType: LetterType.Circular,
                  text: name,
                  textColorHex: '',
                  backgroundColorHex: '',
                ),
              ),
              //! Lesson Card Image
              //* Lesson Card Title
              Spacer(),
              Container(
                child: Column(children: [
                  Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Text(
                          "Student:",
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          softWrap: false,
                          style: TextStyle(
                            color: Color.fromARGB(255, 97, 211, 87),
                            fontSize: 20,
                          ),
                        ),
                        Text(
                          name,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          softWrap: false,
                          style: TextStyle(
                            fontSize: 34,
                          ),
                        ),
                      ],
                    ),
                  ),
                  //*
                ]),
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.only(right: 30.0),
                child:
                    //* Lesson Card Edit Icon
                    Material(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100)),
                  child: Container(
                    height: 50,
                    width: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Color.fromARGB(255, 97, 211, 87),
                    ),
                    child: Center(
                      child: Text(
                        grade == null
                            ? "--"
                            : grade.roundToDouble().toString() + " %",
                      ),
                    ),
                  ),
                ),
                //! End of Lesson Card Edit Icon
              ),
              //! End of Lesson Card Title
            ],
          ),
        ),
      ),
    );
  }
}
