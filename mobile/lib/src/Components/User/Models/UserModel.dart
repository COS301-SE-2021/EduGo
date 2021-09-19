import 'package:json_annotation/json_annotation.dart';
import 'package:mobile/src/Components/User/Controller/UserController.dart';
import 'package:momentum/momentum.dart';

part 'UserModel.g.dart';

enum UserType {
  @JsonValue('Educator')
  Educator,
  @JsonValue('student')
  student
}

@JsonSerializable()
class User {
  @JsonKey(required: true)
  final String email;

  @JsonKey(required: true)
  final String firstName;

  @JsonKey(required: true)
  final String lastName;

  @JsonKey(required: true)
  final String username;

  @JsonKey(required: true)
  final int organisation_id;

  @JsonKey(required: true)
  final UserType userType;

  User(this.email, this.firstName, this.lastName, this.username,
      this.organisation_id, this.userType);

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}

class UserModel extends MomentumModel<UserController> {
  UserModel(UserController controller,
      {this.user, this.isLoggedIn = false, this.loadingData = true})
      : super(controller);

  User? user;
  bool isLoggedIn;
  bool loadingData;

  @override
  void update({User? user, bool? isLoggedIn, bool? loadingData}) {
    UserModel(
      controller,
      user: user ?? this.user,
      isLoggedIn: isLoggedIn ?? this.isLoggedIn,
      loadingData: loadingData ?? this.loadingData,
    ).updateMomentum();
  }
}
