import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:model_viewer/model_viewer.dart';

void main(List<String> args) {
  //runApp()
}

class App extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AppState();
  }

}

class AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('EduGo')
        ),
        body: ModelList(),
      )
    );
  }

}
Future<List<Model>> fetchModels() async {
  final response = await http.post(Uri.parse('http://localhost:8080/virtualEntity/getTestModels'));

  if (response.statusCode == 200) {
    final List list = jsonDecode(response.body)['models'];
    return list.map((e) => Model.fromJSON(e));
  }
  else {
    //TODO: Make this a proper exception!!!
    throw Exception('Bruh...');
  }
}

class Model {
  final String name;
  final String link;

  Model({
    @required this.name,
    @required this.link
  });

  factory Model.fromJSON(Map<String, dynamic> json) {
    return Model(name: json['name'], link: json['link']);
  }
}

class ModelList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ModelListState();
  }
}

class ModelListState extends State<ModelList> {
  List<Model> models;

  @override
  void initState() async {
    super.initState();
    models = await fetchModels();
  }

  @override
  Widget build(BuildContext context) {
    var modelCards = models.map((e) {
      return ModelCardData(
        e.name, 
        e.link,
        () => Navigator.push(context, MaterialPageRoute(builder: (context) => getPage(page: e))));
    });

    return ListView(
      children: modelCards.map((e) => ModelCard(data: e,)).toList(),
    );
  }
}

class ModelCardData {
  ModelCardData(this.name, this.link, this.tap);
  final String name;
  final String link;
  final Function tap;
}

class ModelCard extends StatelessWidget {
  final ModelCardData data;
  ModelCard({
    Key key,
    @required this.data
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        splashColor: Colors.blue.withAlpha(30),
        onTap: () {data.tap();},
        child: ListTile(
          title: Text(data.name),
        )
      ),
    );
  }
}

class getPage extends StatelessWidget {
  final Model page;

  getPage({
    Key key,
    @required this.page
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar: AppBar(
      title: Text(page.name),
      automaticallyImplyLeading: false,
      backgroundColor: Colors.black,
    ),
    body: ModelViewer(
      src: page.link,
      backgroundColor: Colors.teal[50],
      alt: page.name,
      autoPlay: true,
      ar: true,
      autoRotate: true,
      cameraControls: true,
      arScale: 'auto',
    )
  );
  }
}