import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:model_viewer/model_viewer.dart';
import 'globals.dart' as globals;

class VirtualEntityData {
  final int ve_id;

  VirtualEntityData({this.ve_id});

  factory VirtualEntityData.fromJson(Map<String, dynamic> json) {
    return VirtualEntityData(ve_id: json["ve_id"]);
  }
}

class VirtualEntity {
  final int id;
  final String title;
  final String description;
  final Model model;

  VirtualEntity({this.id, this.title, this.description, this.model});

  factory VirtualEntity.fromJson(Map<String, dynamic> json) {
    return VirtualEntity(id: json["id"], title: json["title"], description: json["description"], model: Model.fromJson(json["model"]));
  }
}

class Model {
  final String name;
  final String description;
  final String file_name;
  final String file_link;
  final String file_type;
  final int file_size;

  Model({this.name, this.description, this.file_name, this.file_link, this.file_type, this.file_size});

  factory Model.fromJson(Map<String, dynamic> json) {
    return Model(name: json["name"], description: json["description"], file_name: json["file_name"], file_link: json["file_link"], file_type: json["file_type"], file_size: json["file_size"]);
  }
}

Future<VirtualEntity> getVirtualEntity(int id) async {
  final response = await http.post(
    Uri.parse("${globals.baseUrl}virtualEntity/getVirtualEntity"), 
    headers: <String, String>{
      'Content-Type': 'application/json',
    },
    body: jsonEncode(<String, int>{'id': id}));
  print(response.body);

  if (response.statusCode == 200) {
    return VirtualEntity.fromJson(jsonDecode(response.body));
  }
  else {
    //TODO throw an exception if the status code is not 200
  }
}

class VirtualEntityView extends StatefulWidget {
  final VirtualEntityData data;

  VirtualEntityView({@required this.data});

  @override
  State<StatefulWidget> createState() {
    return _VirtualEntityViewState(data: data);
  }
}

class _VirtualEntityViewState extends State<VirtualEntityView> {
  final VirtualEntityData data;
  Future<VirtualEntity> entity;
  String name = 'None';

  _VirtualEntityViewState({@required this.data});

  @override
  void initState() {
    super.initState();
    this.entity = getVirtualEntity(data.ve_id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Virtual Entity: ${name}"),
      ),
      body: FutureBuilder<VirtualEntity>(
        future: entity,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            setState(() {
              name = snapshot.data.model.name;
            });
            return ModelViewer(
              backgroundColor: Colors.teal[50],
              src: snapshot.data.model.file_link,
              alt: snapshot.data.model.name,
              autoPlay: true,
              ar: true,
              arScale: 'auto',
              autoRotate: true,
              cameraControls: true,
            );
          }
          else if (snapshot.hasError) {
            return Text(snapshot.error);
          }
          else
            return Center(child: CircularProgressIndicator());
        },
      )
    );
  }
}

