import 'package:flutter/material.dart';
import 'package:mobile/src/Pages/VirtualEntityPage/Controller/VirtualEntityController.dart';
import 'package:mobile/src/Pages/VirtualEntityPage/Models/VirtualEntityModels.dart';
import 'package:model_viewer/model_viewer.dart';

class VirtualEntityView extends StatefulWidget {
  final VirtualEntityData data;

  VirtualEntityView({required this.data});

  @override
  State<StatefulWidget> createState() {
    return _VirtualEntityViewState(data: data);
  }
}

class _VirtualEntityViewState extends State<VirtualEntityView> {
  final VirtualEntityData data;
  late Future<VirtualEntity> entity;

  @override
  void initState() {
    super.initState();
    this.entity = getVirtualEntity(data.ve_id);
  }

  _VirtualEntityViewState({required this.data});
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
            body: ModelViewer(
              backgroundColor: Colors.teal[50],
              src: snapshot.data!.model!.file_link,
              alt: snapshot.data!.model!.name,
              ar: true,
              arScale: 'auto',
              autoRotate: true,
              cameraControls: true,
            )
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