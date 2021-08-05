/**
   * This widget will be a stateless widget and is responsible for displaying the 
   * subjects as cards. There will be a title, grade and subject image that can be passed 
   * into the constructor when displaying the subjects
   */
import 'package:flutter/material.dart';
import 'package:mobile/src/Pages/LessonsPage/View/LessonsPage.dart';

class LessonsCard extends StatelessWidget {
  final String title;

  //final *type* subjectImage

  LessonsCard({
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 280,
      width: 280,

      child: Card(
        semanticContainer: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        clipBehavior: Clip.antiAlias,
        color: Colors.black,
        //This allows the card to be clickable so that when clicked,
        // it will go to the lessons for that subject
        child: new InkWell(
          onTap: () {
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //       builder: (context) => LessonsPage()),
            // );
          },
          child: Container(
            child: Align(
              alignment: Alignment.center,
              child: Text(
                "$title",
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
        ),
      ),

      //),
    );
  }
}
