import 'package:flutter/material.dart';
import 'package:mobile/src/Pages/VirtualEntityPage/Controller/VirtualEntityController.dart';
import 'package:mobile/src/Pages/VirtualEntityPage/Models/VirtualEntityModels.dart';
import 'package:mobile/src/Pages/VirtualEntityPage/View/ARWindow.dart';
import 'package:http/http.dart' as http;

class VirtualEntityView extends StatefulWidget {
  final int ve_id;

  VirtualEntityView({required this.ve_id});
  static String id = "virtual_entity";

  @override
  State<StatefulWidget> createState() {
    return _VirtualEntityViewState(id: ve_id);
  }
}

class _VirtualEntityViewState extends State<VirtualEntityView> {
  final int id;
  late Future<VirtualEntity> entity;

  _VirtualEntityViewState({required this.id});

  @override
  void initState() {
    super.initState();
    this.entity = getVirtualEntity(id, client: http.Client());
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<VirtualEntity>(
      future: entity,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Scaffold(
            appBar: AppBar(
              title: Text(snapshot.data!.model!.name),
            ),
            body: ARWindow(uri: snapshot.data!.model!.file_link,)
          );
        }
        else if (snapshot.hasError) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Virtual Entity'),
            ),
            body: Center(child: Text('There was an error loadinng the virtual entity'),)
          );
        }
        else {
          return Scaffold(
            appBar: AppBar(
              title: Text('Loading...')
            ),
            body: Center(child: CircularProgressIndicator())
          );
        }
      }
    );
  }
}