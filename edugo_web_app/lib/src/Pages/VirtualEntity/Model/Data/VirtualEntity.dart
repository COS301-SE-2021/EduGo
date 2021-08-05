class VirtualEntity {
  String _name;
  String _description;
  String _id;
  String _virtualEntity3dModelLink;
  VirtualEntity({
    virtualEntity3dModelLink,
    name,
    description,
    id,
  })  : _description = description,
        _virtualEntity3dModelLink = virtualEntity3dModelLink,
        _name = name,
        _id = id;

  void setVirtualEntityName(String name) {
    _name = name;
  }

  void setVirtualEntityId(String id) {
    _id = id;
  }

  void setVirtualEntityDescription(String description) {
    _description = description;
  }

  void setVirtualEntity3dModelLink(String virtualEntity3dModelLink) {
    _virtualEntity3dModelLink = virtualEntity3dModelLink;
  }

  String getVirtualEntityName() {
    return _name;
  }

  String getVirtualEntityId() {
    return _id;
  }

  String getVirtualEntityDescription() {
    return _description;
  }

  String getVirtualEntity3dModelLink() {
    return _virtualEntity3dModelLink;
  }
}
