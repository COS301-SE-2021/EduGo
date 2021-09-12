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
      decoration: BoxDecoration(border: Border.all(color: Colors.green)),
      child: Column(
        //crossAxisAlignment: CrossAxisAlignment.stretch,
        //mainAxisAlignment: MainAxisAlignment.
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              width: MediaQuery.of(context).size.width / 2,
              height: MediaQuery.of(context).size.width / 16,
              child: Container(
                child: Text(
                  '${description}',
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 3,
                  softWrap: true,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
