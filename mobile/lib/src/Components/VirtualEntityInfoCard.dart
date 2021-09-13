/**
   * This widget will be a stateless widget and is responsible for 
   * displaying the Virtual entity info as cards. There is just a 
   * string of descrtiptions to be displayed
*/
import 'package:flutter/material.dart';

/*------------------------------------------------------------------------------
 *       Virtual Entity info card used in the Virtual entity page 
 *------------------------------------------------------------------------------
 */

class VirtualEntityInfoCard extends StatelessWidget {
  //Holds the subject title
  final String description;

//This is the virtual card constructor. it requires a list of strings
//Of the descriptions of the virtual entity
  VirtualEntityInfoCard({required this.description});

  @override
  Widget build(BuildContext context) {
    //This is the main subject card design. It is all in a container and
    //displays info like the subject photo, subject title, subject educator

    return Container(
      // decoration: BoxDecoration(border: Border.all(color: Colors.green)),
      child: Expanded(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  '${description}',
                  textAlign: TextAlign.left,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 3,
                  softWrap: true,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
