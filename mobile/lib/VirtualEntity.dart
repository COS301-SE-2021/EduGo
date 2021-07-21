import 'package:flutter/material.dart';

class VirtualEntityData {
  final int ve_id;

  VirtualEntityData({this.ve_id});

  factory VirtualEntityData.fromJson(Map<String, dynamic> json) {
    return VirtualEntityData(ve_id: json["ve_id"]);
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

  _VirtualEntityViewState({@required this.data});
  
  @override
  Widget build(BuildContext context) {
    
  }
}