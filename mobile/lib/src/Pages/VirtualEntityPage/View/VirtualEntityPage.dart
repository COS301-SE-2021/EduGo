import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
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
                    child: ARWindow(uri: snapshot.data!.model!.fileLink,),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    color: Colors.green,
                    height: MediaQuery.of(context).size.height / 4,
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListView(
                        //physics: NeverScrollableScrollPhysics(),
                        //primary: false,
                        scrollDirection: Axis.horizontal,
                        children: List.generate(
                          snapshot.data!.description.length,
                          (index) => VirtualEntityInfoCard(
                            description: snapshot.data!.description[index],
                          ),
                        ),
                        // new Container(
                        //   height: MediaQuery.of(context).size.height,
                        //   color: Colors.blue,
                        //   child: new ListView(
                        //     primary: false,

                        //     //physics: NeverScrollableScrollPhysics(),
                        //     scrollDirection: Axis.horizontal,
                        //     children: new List.generate(
                        //       snapshot.data!.description.length,
                        //       (index) => VirtualEntityInfoCard(
                        //         description:
                        //             snapshot.data!.description[index],
                        //       ),
                        //     ),
                        //   ),
                        // ),
                        //],
                      ),
                    ),

                    ///////////////////////////////////
                    // child: new GridView.count(
                    //   crossAxisCount: 2,
                    //   mainAxisSpacing: 5,
                    //   childAspectRatio: MediaQuery.of(context).size.height,

                    //   primary: false,
                    //   scrollDirection: Axis.horizontal,
                    //   //padding: const EdgeInsets.only(top: 20),
                    //   //  crossAxisSpacing: 0,
                    //   shrinkWrap: true,
                    //   children: new List.generate(
                    //     snapshot.data!.description.length,
                    //     (index) => VirtualEntityInfoCard(
                    //       description: snapshot.data!.description[index],
                    //     ),
                    //   ),
                    /////////////////////////////////
                    ///
                    ///
                    // children: <Widget>[
                    //   new Container(
                    //     color: Colors.green,
                    //     height: MediaQuery.of(context).size.height,
                    //       child: new GridView.count(
                    //         childAspectRatio:
                    //             MediaQuery.of(context).size.height / 400,
                    //         primary: false,
                    //         //padding: const EdgeInsets.only(top: 20),
                    //         crossAxisSpacing: 0,
                    //         shrinkWrap: true,

                    //         // mainAxisSpacing: 5,
                    //         //makes 1 cards per row
                    //         crossAxisCount: 1,
                    //         scrollDirection: Axis.horizontal,
                    //         children: new List.generate(
                    //           snapshot.data!.description.length,
                    //           (index) => VirtualEntityInfoCard(
                    //             description: snapshot.data!.description[index],
                    //           ),
                    //         ),
                    //),
                    // ),
                    //],
                  ),
                ),
                // )
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
