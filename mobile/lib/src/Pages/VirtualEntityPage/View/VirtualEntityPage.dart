import 'package:flutter/material.dart';
import 'package:mobile/src/Pages/VirtualEntityPage/Controller/VirtualEntityController.dart';
import 'package:mobile/src/Pages/VirtualEntityPage/Models/VirtualEntityModels.dart';
import 'package:mobile/src/Pages/VirtualEntityPage/View/ARWindow.dart';
import 'package:http/http.dart' as http;
import 'package:mobile/src/VirtualEntityInfoCard.dart';

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
                  // if(snapshot.data!.information.isNotEmpty)
                  Container(
                    //child: SingleChildScrollView(
                    child: Column(
                      children: [
                        GridView.count(
                          //This makes 2 cards appear. So effectively
                          //two cards per page. (2 rows, 1 card per row)
                          childAspectRatio:
                              MediaQuery.of(context).size.height / 520,
                          primary: false,
                          padding: const EdgeInsets.all(10),
                          crossAxisSpacing: 0,
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          mainAxisSpacing: 20,
                          //makes 1 cards per row
                          crossAxisCount: 1,
                          //Call subject card here and pass in all arguments required
                          children: snapshot.data!.information
                              .map(
                                (information) => VirtualEntityInfoCard(
                                    information: information),
                              )
                              .toList(),
                        ),
                      ],
                    ),
                    //),
                  ),
                  ARWindow(
                    uri: snapshot.data!.model!.fileLink,
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
        });
  }
}
