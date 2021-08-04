import 'package:json_annotation/json_annotation.dart';
import 'package:mobile/src/Components/User/Controller/UserController.dart';
import 'package:momentum/momentum.dart';

part 'UserModel.g.dart';

enum UserType {
  @JsonValue('Educator') Educator,
  @JsonValue('Student') Student
}

@JsonSerializable()
class User {
  @JsonKey(required: true)
  final int id;

  @JsonKey(required: true)
  final String username;

  @JsonKey(required: true)
  final String firstName;

  @JsonKey(required: true)
  final String lastName;

  @JsonKey(required: true)
  final String email;

  @JsonKey(required: true)
  final UserType type;

  User(this.id, this.username, this.firstName, this.lastName, this.email, this.type);

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}

class UserModel extends MomentumModel<UserController> {
  UserModel(
    UserController controller,
    {this.user}
  ) : super(controller);

  User? user;

  @override
  void update({User? user}) {
    UserModel(controller, user: user ?? this.user).updateMomentum();
  }
}