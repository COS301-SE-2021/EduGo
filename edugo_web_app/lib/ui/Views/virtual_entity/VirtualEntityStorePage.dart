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
  Future<http.Response> fetchEntities() {
    return http.post(
        Uri.parse('http://localhost:8080/virtualEntity/getVirtualEntities'));
  }

  @override
  Widget build(BuildContext context) {
    fetchEntities().then((value) {
      setState(() {
        entities = value.body;
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
                      // Container(
                      //   child: Column(children: <Widget>[
                      //     Text(
                      //       "Name : " + "title",
                      //       style: TextStyle(color: Colors.black, fontSize: 20),
                      //     ),
                      //     SizedBox(
                      //       height: 20,
                      //     ),
                    ],
                  ),
                ),
              ],
            )));
  }
}
