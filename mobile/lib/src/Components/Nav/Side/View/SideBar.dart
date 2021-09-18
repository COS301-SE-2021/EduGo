import 'package:flutter/material.dart';
import 'package:mobile/src/Components/Nav/Side/Model/ProfileWidget.dart';
import 'package:mobile/src/Components/User/Controller/UserController.dart';
import 'package:mobile/src/Components/User/Models/UserModel.dart';
import 'package:mobile/src/Pages/LoginPage/View/LoginPage.dart';
import 'package:mobile/src/Pages/OrganisationsPage/View/OrganisationsPage.dart';
import 'package:mobile/src/Pages/PreferencesPage/Controller/Preferences.dart';
import 'package:mobile/src/Pages/PreferencesPage/View/PreferencesPage.dart';
import 'package:mobile/src/Pages/SettingsPage/View/SettingsPage.dart';
import 'package:momentum/momentum.dart';

class SideBar extends StatefulWidget {
  SideBar({Key? key}) : super(key: key);

  @override
  _SideBarState createState() => _SideBarState();
}

//new User(
//     0, 'username', 'firstName', 'lastName', 'email', UserType.Student),
// loadingData: true);
class _SideBarState extends State<SideBar> {
  @override
  Widget build(BuildContext context) {
    //return view
    return MomentumBuilder(
        controllers: [UserController],
        builder: (context, snapshot) {
          //Get a specific controller (UserController) to call needed functions (login)
          UserController userController =
              Momentum.controller<UserController>(context);
          //laod user data for side bar
          userController.loadUser();
          final userModel = snapshot<UserModel>();

          if (userModel.loadingData) {
            return CircularProgressIndicator();
          }
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
                    decoration: BoxDecoration(
                      color: Colors.blue,
                    ),
                    child: Text(userModel.user!.firstName),
                  ),
                  ListTile(
                    leading: Icon(Icons.verified_user),
                    title: Text('Preferences'),
                    onTap: () =>
                        //Leads to Preferences page
                        MomentumRouter.goto(
                      context,
                      PreferencesPage,
                      transition: (context, page) {
                        return MaterialPageRoute(builder: (context) => page);
                      },
                    ),
                  ),
                  ListTile(
                    leading: Icon(Icons.settings),
                    title: Text('Settings'),
                    onTap: () =>
                        //Leads to Settings page
                        MomentumRouter.goto(
                      context,
                      SettingsPage,
                      transition: (context, page) {
                        return MaterialPageRoute(builder: (context) => page);
                      },
                    ),
                  ),
                  ListTile(
                    leading: Icon(Icons.exit_to_app),
                    title: Text('Logout'),
                    onTap: () => {MomentumRouter.goto(context, LoginPage)},
                  ),
                ],
              ),
            ),
          );
          ;
        });
  }
}
