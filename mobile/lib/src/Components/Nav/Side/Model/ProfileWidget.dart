import 'dart:math';

import 'package:flutter/material.dart';

class ProfileWidget extends StatelessWidget {
//Data needed to display user profile details
  final user; //User model created in Preferences class
  final bool
      isEdit; //todo controller: when click on image can select an image to upload, can edit name and org (maybe use stack w/ icon that leads to page or textfields)
  final VoidCallback
      onClicked; //todo when edit icon is clicked, function must execute

//Constructor
  const ProfileWidget({
    Key? key,
    required this.user,
    this.isEdit = false,
    required this.onClicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //Widget returned makes for a decent display, despite it's limited attributes
    return UserAccountsDrawerHeader(
      decoration: BoxDecoration(
          //remove borders and background color
          color: Colors.transparent,
          border: Border.all(color: Colors.transparent)),
      accountName: Text(user.name), //User's name
      accountEmail: Text(user.current_organistion), //Current organization
      currentAccountPicture: CircleAvatar(
          //profile picture
          radius: 30.0,
          //backgroundImage: new AssetImage(user.image_path)),
          backgroundImage: NetworkImage('https://edugo-files.s3.af-south-1.amazonaws.com/test_images/profile.jpg')
      )
    );
  }
}
