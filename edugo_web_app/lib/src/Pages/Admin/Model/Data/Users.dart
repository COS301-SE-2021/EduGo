import 'package:edugo_web_app/src/Pages/Admin/Model/Data/User.dart';

class Users {
  final List<User> users;

  Users({this.users});

  factory Users.fromJson(Map<String, dynamic> usersJson) {
    var list = usersJson['educator'] as List;
    List<User> usersList = list.map((user) => User.fromJson(user)).toList();
    return Users(users: usersList);
  }
}
