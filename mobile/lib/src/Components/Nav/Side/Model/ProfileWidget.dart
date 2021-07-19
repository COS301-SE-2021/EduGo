import 'package:flutter/material.dart';

class ProfileWidget extends StatelessWidget {
  final String image_path;
  final bool isEdit;
  final VoidCallback onClicked;

  const ProfileWidget({
    Key? key,
    required this.image_path,
    this.isEdit = false,
    required this.onClicked,
  }) : super(key: key);
//todo when click on image can select an image to upload
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Stack(children: [
      CircleAvatar(
        radius: 30.0,
        backgroundImage: AssetImage(
          "../assets/images/profile.jpg",
        ),
        backgroundColor: Colors.transparent,
      )
    ]));
  }
}
