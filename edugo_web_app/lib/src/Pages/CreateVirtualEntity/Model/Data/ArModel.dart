class ArModel {
  String _name;
  String _description;
  String _file_link;
  int _file_size;
  String _file_type;
  String _file_name;
  String _preview_img;

  ArModel(
      {name,
      description,
      file_name,
      file_link,
      file_size,
      file_type,
      preview_img})
      : _description = description,
        _file_name = file_name,
        _name = name,
        _file_link = file_link,
        _file_size = file_size,
        _file_type = file_type,
        _preview_img = preview_img;

  void setName(String name) {
    _name = name;
  }

  void setFileName(String name) {
    _file_name = name;
  }

  void setDescription(String description) {
    _description = description;
  }

  void setFileLink(String link) {
    _file_link = link;
  }

  void setFileSize(int size) {
    _file_size = size;
  }

  void setFileType(String type) {
    _file_type = type;
  }

  Map<String, dynamic> toJson() => {
        "name": _name,
        "description": _description,
        "file_link": _file_link,
        "file_size": _file_size,
        "file_type": _file_type,
        "file_name": _file_name,
        "preview_img": ""
      };
}
