//
// Generated file. Do not edit.
//

// ignore_for_file: lines_longer_than_80_chars

import 'package:catcher/core/catcher_web.dart';
import 'package:file_picker/src/file_picker_web.dart';
import 'package:flutter_dropzone_web/flutter_dropzone_plugin.dart';
import 'package:fluttertoast/fluttertoast_web.dart';

import 'package:flutter_web_plugins/flutter_web_plugins.dart';

// ignore: public_member_api_docs
void registerPlugins(Registrar registrar) {
  CatcherWeb.registerWith(registrar);
  FilePickerWeb.registerWith(registrar);
  FlutterDropzonePlugin.registerWith(registrar);
  FluttertoastWebPlugin.registerWith(registrar);
  registrar.registerMessageHandler();
}
