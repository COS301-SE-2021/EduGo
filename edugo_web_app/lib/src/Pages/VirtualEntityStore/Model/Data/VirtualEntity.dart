class VirtualEntity {
  String _name;
  List<dynamic> _description;
  int _id;
  bool _public;
  String _thumbNail;

  VirtualEntity({name, description, id, thumbNail, public})
      : _description = description,
        _name = name,
        _id = id,
        _public = public,
        _thumbNail = thumbNail;

  String getVirtualEntityName() {
    return _name;
  }

  int getVirtualEntityId() {
    return _id;
  }

  String getThumbNail() {
    return _thumbNail;
  }

  bool getPublic() {
    return _public;
  }

  List<dynamic> getVirtualEntityDescription() {
    return _description;
  }

  factory VirtualEntity.fromJson(Map<String, dynamic> json) {
    return VirtualEntity(
        name: json['title'] as String,
        id: json['id'] as int,
        description: json['description'] as List<dynamic>,
        public: json['public'] == null ? true : json['public'] as bool,
        thumbNail:
            json['model'] == null ? '' : json['model']['fileLink'] as String);
  }
}
