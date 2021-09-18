class VirtualEntity {
  String _name;
  List<dynamic> _description;
  int _id;
  bool _public;
  String _thumbNail;
  String _model;

  VirtualEntity({name, description, id, model, thumbNail, public})
      : _description = description,
        _name = name,
        _model = model,
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

  String getModel() {
    return _model;
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
        model: json['model'] == null ? '' : json['model']['fileLink'] as String,
        public: json['public'] == null ? true : json['public'] as bool,
        thumbNail:
            json['model'] == null ? '' : json['model']['thumbnail'] as String);
  }
}
