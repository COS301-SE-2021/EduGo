import 'package:edugo_web_app/ui/Views/subject/EditSubjectPage.dart';
import 'package:flutter/material.dart';

class SubjectCard extends StatelessWidget {
  // SubjectCard({
  final String title;
  final String grade;
  final String description;
  SubjectCard({this.title, this.grade, this.description}) {}

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 350,
      width: 280,
      child: SingleChildScrollView(
        child: Card(
          clipBehavior: Clip.antiAlias,
          color: Color.fromARGB(255, 97, 211, 87),
          child: Column(
            children: [
              Image.asset("../assets/images/Maths.jpeg"),
              Container(
                child: Row(
                  children: <Widget>[
                    // Expanded(
                    //child:
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          'Title: ' + "$title",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Grade: ' + "$grade",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Description: ' + "$description",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: MaterialButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100)),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => EditSubjectPage()),
                    );
                  },
                  child: Icon(
                    Icons.edit_outlined,
                    color: Colors.white,
                  ),
                ),
              )
            ],
          ),
          //),
        ),
      ),
    );
  }
}
