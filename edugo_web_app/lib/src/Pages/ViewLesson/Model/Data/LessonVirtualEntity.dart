class LessonVirtualEntity {
  String _name;
  List<dynamic> _description;
  int _id;
  bool _public;

  LessonVirtualEntity({name, description, id, modelLink, public})
      : _description = description,
        _name = name,
        _id = id,
        _public = public;

  String getVirtualEntityName() {
    return _name;
  }

  int getVirtualEntityId() {
    return _id;
  }

  bool getPublic() {
    return _public;
  }

  List<dynamic> getVirtualEntityDescription() {
    return _description;
  }

  factory LessonVirtualEntity.fromJson(Map<String, dynamic> json) {
    return LessonVirtualEntity(
        name: json['title'] as String,
        id: json['id'] as int,
        description: json['description'] as List<dynamic>,
        public: json['public'] == null ? true : json['public'] as bool);
  }
}
