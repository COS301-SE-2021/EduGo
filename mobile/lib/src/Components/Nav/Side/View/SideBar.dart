import 'package:flutter/material.dart';
import 'package:mobile/src/Components/Nav/Side/Model/ProfileWidget.dart';
//import 'package:mobile/src/Components/Nav/Side/Model/ProfileWidget.dart';
import 'package:mobile/src/Pages/LessonsPage/View/LessonsPage.dart';
import 'package:mobile/src/Pages/OrganisationsPage/View/OrganisationsPage.dart';
import 'package:mobile/src/Pages/PreferencesPage/Controller/Preferences.dart';
import 'package:mobile/src/Pages/PreferencesPage/View/PreferencesPage.dart';
import 'package:mobile/src/Pages/SettingsPage/View/SettingsPage.dart';

class SideBar extends StatefulWidget {
  SideBar({Key? key}) : super(key: key);

  @override
  _SideBarState createState() => _SideBarState();
}

//todo momentum name and surname
class _SideBarState extends State<SideBar> {
  final user = Preferences.user;
  @override
  Widget build(BuildContext context) {
    return Align(
      //Align the side bar
      alignment: Alignment.centerRight,
      heightFactor: 1.00,
      widthFactor: 1.00,
      child: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            //Drawer header onsists of a profile picture, the user's current org, the user's name and surname
            DrawerHeader(
              //Row
              child: ProfileWidget(
                  user: user, isEdit: false, onClicked: () async {}),
            ),
            //All List tiles below have icons and titled tiles that lead to their relevant pages
            // ListTile(
            //   leading: Icon(Icons.summarize_outlined),
            //   title: Text('Lessons'),
            //   onTap: () => Navigator.push(
            //     context,
            //     MaterialPageRoute(builder: (context) => LessonsPage()),
            //   ),
            // ),
            ListTile(
              leading: Icon(Icons.verified_user),
              title: Text('Preferences'),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PreferencesPage()),
              ),
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SettingsPage()),
              ),
            ),
            ListTile(
              leading: Icon(Icons.border_color),
              title: Text('Toggle Organisations'),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => OrganisationsPage()),
              ),
            ),
            ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text('Logout'),
              onTap: () => {Navigator.of(context).pop()},
            ),
          ],
        ),
      ),
    );
  }
}
