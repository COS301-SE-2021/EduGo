/**
   * This widget will be a stateless widget and is responsible for displaying the 
   * error that no subjects or lessons are available at the moment. There will be a 
   * string that can be passed into the constructor stating the error. This card will
   * be used when in the SubjectsPage and LessonsPage if there are no subjects/lessons
   * (subject/lesson counbt is null) or if the list is emply/null
*/
import 'package:flutter/material.dart';

/*------------------------------------------------------------------------------
 *                 Erorr Card used in the subject & lesson page 
 *------------------------------------------------------------------------------
 */

class ErrorCard extends StatelessWidget {
  //Holds the error description
  final String errorDescription;

  //This is the subject card constructor. it requires 5 arguments to be passed in
  ErrorCard({
    required this.errorDescription,
  });

  @override
  Widget build(BuildContext context) {
    //This is the main error card design. It is all in a container and
    //displays info like error description.
    return Container(
      color: Colors.black,
      child: Align(
        alignment: Alignment.center,
        child: Text(
          //error description dynamically gets inserted here
          '$errorDescription',
          textAlign: TextAlign.center,
          overflow: TextOverflow.visible,
          maxLines: 8,
          softWrap: true,
          style: TextStyle(
              fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
    );
  }
}
