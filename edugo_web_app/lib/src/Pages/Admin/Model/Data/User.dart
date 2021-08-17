class User {
  String _name;
  bool _admin;

  User({
    name,
    admin,
  })  : _name = name,
        _admin = admin;

  void setAdmin(bool admin) {
    _admin = admin;
  }

  void setName(String name) {
    _name = name;
  }

  bool getAdmin() {
    return _admin;
  }

  String getName() {
    return _name;
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['username'] as String,
      admin: json['admin'] as bool,
    );
  }
}
