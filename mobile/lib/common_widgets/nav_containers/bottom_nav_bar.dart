import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mobile/common_widgets/nav_containers/destination.dart';
import 'package:mobile/pages/DetectMarkerPage.dart';
import 'package:mobile/pages/GradesPage.dart';
import 'package:mobile/pages/HomePage.dart';
import 'package:mobile/pages/SubjectsPage.dart';

/*

            child: FractionallySizedBox(
          child: Bottom_Nav_Bar(),
          heightFactor: 0.1,
          widthFactor: 1.00,
 */
class Bottom_Nav_Bar extends StatefulWidget {
  Bottom_Nav_Bar({Key? key, required this.destination}) : super(key: key);
  final Destination destination;

  @override
  _Bottom_Nav_BarState createState() => _Bottom_Nav_BarState();
}

class _Bottom_Nav_BarState extends State<Bottom_Nav_Bar> {
  late TextEditingController _textController;

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController(
      text: 'sample text: ${widget.destination.title}',
    );
  }

  //widgets (screens) based on icon selected in bottom nav bar
  /*int _selectedIndex = 0;
  List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    SubjectsPage(),
    GradesPage(),
    DetectMarkerPage(),
  ];*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.destination.title}'),
        backgroundColor: widget.destination.color,
      ),
      //backgroundColor: widget.destination.color,
      body: Container(
        padding: const EdgeInsets.all(32.0),
        alignment: Alignment.center,
        child: TextField(controller: _textController),
      ),
    );
    /*return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: FractionallySizedBox(
        heightFactor: 0.25,
        widthFactor: 1.00,
        child: BottomNavigationBar(
          currentIndex: _selectedIndex,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          items: [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home_max_rounded,
                color: Color.fromARGB(255, 97, 211, 87),
              ),
              label: 'HOME',
              activeIcon: Icon(
                Icons.home_max_rounded,
                color: Color.fromARGB(255, 97, 211, 87),
              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home_max_rounded,
                color: Color.fromARGB(255, 97, 211, 87),
              ),
              label: 'CALENDAR',
              activeIcon: Icon(
                Icons.home_max_rounded,
                color: Color.fromARGB(255, 97, 211, 87),
              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home_max_rounded,
                color: Color.fromARGB(255, 97, 211, 87),
                size: 36,
              ),
              label: 'PROFILE',
              activeIcon: Icon(
                Icons.home_max_rounded,
                color: Color.fromARGB(255, 97, 211, 87),
                size: 36,
              ),
            ),
          ],
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
        ),
      ),
      body: _widgetOptions.elementAt(_selectedIndex),
    );*/
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }
}
