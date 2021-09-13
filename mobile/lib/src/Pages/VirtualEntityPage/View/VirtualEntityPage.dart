import 'package:flutter/material.dart';
import 'package:mobile/src/Pages/VirtualEntityPage/Controller/VirtualEntityController.dart';
import 'package:mobile/src/Pages/VirtualEntityPage/Models/VirtualEntityModels.dart';
import 'package:mobile/src/Pages/VirtualEntityPage/View/ARWindow.dart';
import 'package:http/http.dart' as http;
import 'package:mobile/src/Components/VirtualEntityInfoCard.dart';

class VirtualEntityView extends StatefulWidget {
  final VirtualEntityData data;

  VirtualEntityView({required this.data});
  static String id = "virtual_entity";

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
    this.entity = getVirtualEntity(data.ve_id, client: http.Client());
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
              title: Text(snapshot.data!.title),
            ),
            body: Stack(
              children: [
                Container(

                    // ARWindow(
                    //   uri: snapshot.data!.model!.fileLink,
                    // ),
                    ),

                //Align(
                //alignment: Alignment.bottomCenter,
                Container(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: new ListView(
                      children: <Widget>[
                        new Container(
                          color: Colors.black,
                          height: MediaQuery.of(context).size.height / 14,
                          child: new ListView(
                            scrollDirection: Axis.horizontal,
                            children: new List.generate(
                              snapshot.data!.description.length,
                              (index) => VirtualEntityInfoCard(
                                description: snapshot.data!.description[index],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        } else if (snapshot.hasError) {
          return Scaffold(
              appBar: AppBar(
                title: Text('Virtual Entity'),
              ),
              body: Center(
                child: Text('There was an error loadinng the virtual entity'),
              ));
        } else {
          return Scaffold(
              appBar: AppBar(title: Text('Loading...')),
              body: Center(child: CircularProgressIndicator()));
        }
      },
    );
  }
}
