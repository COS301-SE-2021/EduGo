import 'BaseCommand.dart';
import 'dart:html' as html;
import 'dart:typed_data';
import 'dart:convert';

class UploadModelCommand extends BaseCommand {
  List<int> _selectedFile;
  Uint8List _bytesData;
  String filename = "";
  void UploadFile() {
    html.InputElement uploadInput = html.FileUploadInputElement();
    uploadInput.multiple = true;
    uploadInput.draggable = true;
    uploadInput.click();
    uploadInput.onChange.listen((e) {
      final files = uploadInput.files;
      final file = files[0];
      final reader = new html.FileReader();

      reader.onLoadEnd.listen((e) {
        _handleResult(reader.result);
      });
      reader.readAsDataUrl(file);
      filename = file.name;
      return;
    });
    print(filename);
    //print(await UploadModelCommand().run(filename, _selectedFile));
  }

  void _handleResult(Object result) {
    _bytesData = Base64Decoder().convert(result.toString().split(",").last);
    _selectedFile = _bytesData;
  }

  Future<String> run() async {
    // Await some service call
    await UploadFile();
    print(_selectedFile);
    String modelLink = await modelService.UploadModel(filename, _selectedFile);
    return modelLink;
  }
}
