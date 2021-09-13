class ArModel {
  String _fileLink;
  String _previewImg;

  ArModel({fileLink, previewImg})
      : _fileLink = fileLink,
        _previewImg = previewImg;

  void setFileLink(String link) {
    _fileLink = link;
  }

  void setPreviewImage(String imageLink) {
    _previewImg = imageLink;
  }

  Map<String, dynamic> toJson() =>
      {"fileLink": _fileLink, "thumbnail": _previewImg};
}
