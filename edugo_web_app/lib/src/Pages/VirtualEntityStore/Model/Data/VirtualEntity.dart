class VirtualEntity {
  String _name;
  String _description;
  int _id;
  VirtualEntity({
    name,
    description,
    id,
  })  : _description = description,
        _name = name,
        _id = id;

  String getVirtualEntityName() {
    return _name;
  }

  int getVirtualEntityId() {
    return _id;
  }

  String getVirtualEntityDescription() {
    return _description;
  }

  factory VirtualEntity.fromJson(Map<String, dynamic> json) {
    return VirtualEntity(
        name: json['title'] as String,
        id: json['id'] as int,
        description: json['description'] as String);
  }
}
