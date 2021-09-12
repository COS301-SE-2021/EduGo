/**
   * This widget will be a stateless widget and is responsible for displaying the 
   * subjects as cards. There will be a title, grade and subject image that can be passed 
   * into the constructor when displaying the subject cards.
*/
import 'package:flutter/material.dart';
import 'package:mobile/src/Pages/LessonsPage/View/LessonsPage.dart';

/*------------------------------------------------------------------------------
 *                 Subject Card used in the subject page 
 *------------------------------------------------------------------------------
 */

class SubjectCard extends StatelessWidget {
  //Holds the subject title
  final String title;

  //Holds the subject title
  //final String educator;

  //Holds the subject grade
  final int grade;

  //Holds the subject id (no longer needed)
  final int id;

  //Holds how many lessons are in the subject
  final int count;

  //Holds the subject image
  // final String subjectImage;
  final String educator;

//This is the subject card constructor. it requires 5 arguments to be passed in
  SubjectCard({
    required this.title,
    required this.grade,
    required this.id,
    required this.count,
    required this.educator,
  });

  @override
  Widget build(BuildContext context) {
    // return Container(
    //   height: 500,
    //   width: 280,

    //This is the main subject card design. It is all in a container and
    //displays info like the subject photo, subject title, subject educator
    //and how many lessons are in that subject
    return Card(
        semanticContainer: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        clipBehavior: Clip.antiAlias,
        //color: Color.fromARGB(255, 97, 211, 87),
        color: Colors.black,

        //This allows the card to be clickable so that when clicked,
        // it will go to the lessons for that subject
        child: new InkWell(
          onTap: () {
            //This redirects the page to the lessons page on tap
            //and passes in the subject title, and subject id
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => LessonsPage(), //use goto and Momentum
              ),
            );
          },
          child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  colorFilter: ColorFilter.mode(
                      Colors.black.withOpacity(0.4), BlendMode.hue),
                  image: NetworkImage(
                      'https://edugo-files.s3.af-south-1.amazonaws.com/subject-choice.jpg'),
                  //add transparency layer: add white background for name and ahwtaver
                  // image: AssetImage(
                  //     'https://edugo-files.s3.af-south-1.amazonaws.com/test_images/profile.jpg'),
                  fit: BoxFit.fill,
                  //alignment: Alignment.center,
                ),
              ),
              child: Column(
                  //crossAxisAlignment: CrossAxisAlignment.stretch,
                  //mainAxisAlignment: MainAxisAlignment.
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 150, left: 20),
                        //TODO: make this text container flexible and according
                        //to side and not have a fixed width and length

                        child: Container(
                          width: MediaQuery.of(context).size.width / 2,
                          height: MediaQuery.of(context).size.width / 12,
                          child: Text(
                            //If there is a mark, display it.
                            //Els display the two dashes
                            '$title',
                            textAlign: TextAlign.left,
                            //textAlign: TextAlign.left,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            softWrap: true,

                            style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 20, left: 20),
                        child: Container(
                          width: MediaQuery.of(context).size.width / 2,
                          height: MediaQuery.of(context).size.width / 16,
                          child: Container(
                            child: Text(
                              //If there is a mark, display it.
                              //Els display the two dashes
                              '${educator}',
                              textAlign: TextAlign.left,
                              //textAlign: TextAlign.left,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              softWrap: true,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ])),
        ));
  }
}
