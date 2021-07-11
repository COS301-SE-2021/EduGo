import 'package:flutter/material.dart';
import 'package:mobile/src/Components/Nav/Side/Model/ProfileWidget.dart';
import 'package:mobile/src/Pages/LessonsPage/View/LessonsPage.dart';
import 'package:mobile/src/Pages/OrganisationsPage/View/OrganisationsPage.dart';
import 'package:mobile/src/Pages/PreferencesPage/Controller/Preferences.dart';
import 'package:mobile/src/Pages/PreferencesPage/Model/User.dart';
import 'package:mobile/src/Pages/PreferencesPage/View/PreferencesPage.dart';
import 'package:mobile/src/Pages/SettingsPage/View/SettingsPage.dart';

// https://maffan.medium.com/how-to-create-a-side-menu-in-flutter-a2df7833fdfb
class SideBar extends StatefulWidget {
  SideBar({Key? key}) : super(key: key);

  @override
  _SideBarState createState() => _SideBarState();
}

//todo circular profile
//todo mometum name and surname
//todo buttons with icons Lessons, Preferences, Settings, Toggle Organistaions,Logout
class _SideBarState extends State<SideBar> {
  final user = Preferences.user;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      heightFactor: 1.00,
      widthFactor: 1.00,
      child: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
                child: Row(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    ProfileWidget(
                        image_path: user.image_path,
                        isEdit: false,
                        onClicked: () async {}),
                  ],
                ),
                Column(
                  children: <Widget>[
                    Row(
                      children: [
                        Text("Name & surname"),
                      ],
                    ),
                    Row(
                      children: [
                        Text("Organisation"),
                      ],
                    ),
                  ],
                ),
              ],
            )),
            ListTile(
              leading: Icon(Icons.input),
              title: Text('Lessons'),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LessonsPage()),
              ),
            ),
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
