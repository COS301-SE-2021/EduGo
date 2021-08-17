import 'package:edugo_web_app/ui/Views/lesson/CreateLessonPage.dart';
import 'package:edugo_web_app/ui/widgets/EduGoNav/NavBar.dart';
import 'package:edugo_web_app/ui/widgets/subjectCard.dart';
import 'package:flutter/material.dart';

class LessonsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: <Widget>[
        NavBar(),
        Container(
          padding: EdgeInsets.only(top: 40, bottom: 40, left: 100, right: 80),
          margin: EdgeInsets.only(left: 100, top: 100),
          width: MediaQuery.of(context).size.width - 100,
          height: MediaQuery.of(context).size.height - 100,
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.red,
              style: BorderStyle.solid,
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Row(
                  children: [
                    Expanded(
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "Lessons",
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: MaterialButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5))),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CreateLesonPage()),
                          );
                        },
                        minWidth: 50,
                        height: 60,
                        child: Text("Add Lesson.",
                            style: TextStyle(color: Colors.white)),
                        color: Color.fromARGB(255, 97, 211, 87),
                      ),
                    ),
                  ],
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: SubjectCard(),
                )
              ],
            ),
          ),
        ),
      ],
    ));
  }
}
