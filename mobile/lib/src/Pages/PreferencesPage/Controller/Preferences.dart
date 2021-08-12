import 'package:mobile/src/Pages/PreferencesPage/Model/User.dart';

//Store user prefences. more attributes may be added in future
class Preferences {
  static const user = User(
      //image_path: "../assets/images/profile.jpg",
      image_path:
          "https://edugo-files.s3.af-south-1.amazonaws.com/test_images/profile.jpg",
      name: "Mihlali Mgwebi",
      isDarkMode: false,
      current_organistion: "COS Crash Course");
}
