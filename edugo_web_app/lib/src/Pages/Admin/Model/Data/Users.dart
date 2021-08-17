import 'package:edugo_web_app/src/Pages/Admin/Model/Data/User.dart';

class Users {
  final List<User> users;

  Users({this.users});

  factory Users.fromJson(Map<String, dynamic> usersJson) {
    var list = usersJson['data'] as List;
    List<User> usersList =
        list.map((subject) => User.fromJson(subject)).toList();
    return Users(users: usersList);
  }
}
