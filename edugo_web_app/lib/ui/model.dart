import 'package:flutter/material.dart';
import 'package:flutter_cube/flutter_cube.dart';
import 'package:file_picker_cross/file_picker_cross.dart';

class model extends StatefulWidget {
  const model({Key? key}) : super(key: key);

  @override
  State<model> createState() => _modelState();
}

class _modelState extends State<model> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Cube(
            onSceneCreated: (Scene scene) {
              scene.world.add(Object(
                  isAsset: false, fileName: 'assets/material/model.obj'));
            },
          ),
        ],
      ),
    );
  }
}
