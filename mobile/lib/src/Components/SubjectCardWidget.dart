/**
   * This widget will be a stateless widget and is responsible for displaying the 
   * subjects as cards. There will be a title, grade and subject image that can be passed 
   * into the constructor when displaying the subjects
   */
import 'package:flutter/material.dart';
import 'package:mobile/src/Pages/LessonsPage/View/LessonsPage.dart';

class SubjectCard extends StatelessWidget {
  final String title;
  final int grade;
  final int id;
  //final *type* subjectImage

  SubjectCard({required this.title, required this.grade, required this.id});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500,
      width: 280,
      //width: MediaQuery.of(context).size.width - 100,
      //height: MediaQuery.of(context).size.height - 200,
      //child: SingleChildScrollView(
      child: Card(
        clipBehavior: Clip.antiAlias,
        color: Color.fromARGB(255, 97, 211, 87),
        //This allows the card to be clickable so that when clicked,
        // it will go to the lessons for that subject
        child: new InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => LessonsPage()),
            );
          },
          child: Column(
            children: [
              Image.asset("../assets/images/english.jpeg"),
              Container(
                child: Expanded(
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            'Title: ' + "$title",
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            softWrap: false,
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
              // Row(
              //   children: [
              //     Align(
              //       alignment: Alignment.centerRight,
              //       child: Padding(
              //         padding: const EdgeInsets.only(bottom: 8.0),
              //         child: MaterialButton(
              //           minWidth: 15,
              //           shape: RoundedRectangleBorder(
              //               borderRadius: BorderRadius.circular(100)),
              //           onPressed: () {
              //             Navigator.push(
              //               context,
              //               MaterialPageRoute(
              //                   builder: (context) => SubjectsPage()),
              //             );
              //           },
              //           child: Icon(
              //             Icons.delete_outlined,
              //             color: Colors.white,
              //           ),
              //         ),
              //       ),
              //     ),
              //     Expanded(
              //       child: Align(
              //         alignment: Alignment.centerRight,
              //         child: Padding(
              //           padding: const EdgeInsets.only(bottom: 8.0),
              //           child: MaterialButton(
              //             shape: RoundedRectangleBorder(
              //                 borderRadius: BorderRadius.circular(100)),
              //             onPressed: () {
              //               Navigator.push(
              //                 context,
              //                 MaterialPageRoute(
              //                     builder: (context) => EditSubjectPage()),
              //               );
              //             },
              //             child: Icon(
              //               Icons.edit_outlined,
              //               color: Colors.white,
              //             ),
              //           ),
              //         ),
              //       ),
              //     )
              //   ],
              // ),
            ],
          ),
        ),
      ),
      //),
    );
  }
}
