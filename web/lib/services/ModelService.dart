import 'package:http_parser/http_parser.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ModelService {
  Future<String> UploadModel(String filename, List<int> bytes) async {
    Map<String, dynamic> _3DModel;
    var url =
        Uri.parse("http://localhost:8080/virtualEntity/model/uploadModel");
    var request = new http.MultipartRequest("POST", url);
    request.files.add(http.MultipartFile.fromBytes('file', bytes,
        contentType: new MediaType('application', 'octet-stream'),
        filename: filename));
    await request.send().then((result) {
      http.Response.fromStream(result).then((response) {
        if (response.statusCode == 200) {
          _3DModel = jsonDecode(response.body);
        }
      });
    });
    return _3DModel['file_link'];
  }
}
