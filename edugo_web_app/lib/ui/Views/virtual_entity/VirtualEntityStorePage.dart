import 'dart:convert';

import 'package:edugo_web_app/models/EntityModel.dart';
import 'package:edugo_web_app/ui/Views/virtual_entity/VirtualEntityPage.dart';
import 'package:edugo_web_app/ui/widgets/EduGoContainer.dart';
import 'package:edugo_web_app/ui/widgets/EduGoPage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class VirtualEntityStore extends StatefulWidget {
  @override
  State<VirtualEntityStore> createState() => _VirtualEntityStoreState();
}

class _VirtualEntityStoreState extends State<VirtualEntityStore> {
  String entities;
  Entities entityModel;
  Future<http.Response> fetchEntities() {
    return http.post(
        Uri.parse('http://localhost:8080/virtualEntity/getVirtualEntities'));
  }

  Widget getTextWidgets(List<Entity> strings) {
    return new Column(
        children: strings
            .map((item) => new Container(
                    child: Column(children: <Widget>[
                  MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: GestureDetector(
                      child: Container(
                          height: 100,
                          width: 1000,
                          decoration: BoxDecoration(color: Colors.green),
                          child: Column(children: <Widget>[
                            Text(
                              "Name : " + item.title,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              item.description,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                          ])),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  VirtualEntityPage(entityName: "noah")),
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  )
                ])))
            .toList());
  }

  @override
  Widget build(BuildContext context) {
    fetchEntities().then((value) {
      setState(() {
        entities = value.body;
        entityModel = Entities.fromJson(jsonDecode(entities));
      });
    });
    return EduGoPage(
        child: EduGoContainer(
            width: MediaQuery.of(context).size.width - 100,
            height: MediaQuery.of(context).size.height - 70,
            child: Column(
              children: <Widget>[
                Align(
                    alignment: Alignment.topLeft,
                    child: Text("EduGo Virtual Entity Store",
                        style: TextStyle(fontSize: 25))),
                SizedBox(height: 50),
                Container(
                  height: MediaQuery.of(context).size.height - 360,
                  child: ListView(
                    padding: EdgeInsets.symmetric(vertical: 60),
                    shrinkWrap: true,
                    children: <Widget>[
                      getTextWidgets(entityModel.entities),
                    ],
                  ),
                ),
              ],
            )));
  }
}
