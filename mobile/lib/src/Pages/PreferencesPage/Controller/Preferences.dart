import 'package:mobile/src/Pages/PreferencesPage/Model/User.dart';

//Store user prefences. more attributes may be added in future
class Preferences {
  static const user = User(
      image_path: "../assets/images/profile.jpg",
      name: "Mihlali Mgwebi",
      isDarkMode: false,
      current_organistion: "COS Crash Course");
}
