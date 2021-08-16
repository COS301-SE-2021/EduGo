import 'package:edugo_web_app/src/Pages/EduGo.dart';

class VirtualEntityApiController
    extends MomentumController<VirtualEntityApiModel> {
  @override
  VirtualEntityApiModel init() {
    return VirtualEntityApiModel(
      this,
    );
  }

  void createVirtualEntity(context) async {
    MomentumRouter.goto(context, LessonsView);
    var viewBoundVirtualEntityController =
        controller<ViewBoundVirtualEntityController>();
    var quizBuilderController = controller<QuizBuilderController>();
    var url = Uri.parse(
        'http://43e6071f3a8e.ngrok.io/virtualEntity/createVirtualEntity');
    var response = await post(url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization':
              Momentum.controller<SessionController>(context).getToken(),
        },
        body: jsonEncode(<String, String>{
          'title': viewBoundVirtualEntityController.getName(),
          'description': viewBoundVirtualEntityController.getDescription(),
          'modelLink': viewBoundVirtualEntityController.get3dModelLink(),
          'quiz': quizBuilderController.getQuizBuilderResult(),
        })).then((value) {
      print(value.body);
    });
    if (response.statusCode == 200) {
      MomentumRouter.goto(context, EducatorVirtualEntitiesView);
    }
  }

// Todo: Get Virtual Entity For Viewing
//! Function Calls API and sets the relevant fields of current VirtualEntity

  void preview3DModel() {}

  void clearLinkTo3DModel() {
    model.setViewBoundVirtualEntity3dModelLink(virtualEntity3dModelLink: "");
  }
}

//***************************************************************************************
//*                                                                                     *
//*       Return a list of virtual entities to populate the virtual entity store        *
//*                                                                                     *
//***************************************************************************************
  // void getVirtualEntities(BuildContext context) {
  //   List<Widget> enitites = <Widget>[];
  //   for (int i = 0; i < 12; i++) {
  //     enitites.add(
  //       Card(
  //         elevation: 40,
  //         shape:
  //             RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
  //         shadowColor: Colors.green,
  //         child: Center(
  //           child: Column(
  //             mainAxisSize: MainAxisSize.min,
  //             children: <Widget>[
  //               ListTile(
  //                 title: Column(
  //                   children: [
  //                     Icon(
  //                       Icons.view_in_ar_outlined,
  //                       size: 60,
  //                     ),
  //                     SizedBox(
  //                       height: 30,
  //                     ),
  //                     Align(
  //                         alignment: Alignment.center,
  //                         child: Text('Mish the Skeleton',
  //                             style: TextStyle(fontSize: 22))),
  //                   ],
  //                 ),
  //                 subtitle: Column(
  //                   children: [
  //                     SizedBox(
  //                       height: 10,
  //                     ),
  //                     Align(
  //                         alignment: Alignment.center,
  //                         child: Text('Entity by: Mr TN Mafaralala')),
  //                   ],
  //                 ),
  //               ),
  //               SizedBox(
  //                 height: 30,
  //               ),
  //               TextButton(
  //                 child: const Text(
  //                   'View Entity',
  //                   style: TextStyle(
  //                       color: Color.fromARGB(255, 97, 211, 87), fontSize: 18),
  //                 ),
  //                 onPressed: () {
  //                   updateVirtualEntityName("Mish the Astronaut");
  //                   MomentumRouter.goto(context, ViewVirtualEntityView);
  //                 },
  //               ),
  //             ],
  //           ),
  //         ),
  //       ),
  //     );
  //   }
  //   model.updateVirtualEntityStore(virtualEntities: enitites);
  // }

