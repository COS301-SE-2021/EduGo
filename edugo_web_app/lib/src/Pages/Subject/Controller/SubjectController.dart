import 'package:edugo_web_app/src/Pages/EduGo.dart';

class SubjectController extends MomentumController<SubjectModel> {
  @override
  SubjectModel init() {
    return SubjectModel(this,
        viewBoundSubject: Subject(), currentSubject: Subject());
  }

  void setViewBoundSubjectTitle(String subjectTitle) {
    model.setViewBoundSubjectTitle(subjectTitle: subjectTitle);
  }

  void setViewBoundSubjectGrade(String subjectGrade) {
    model.setViewBoundSubjectGrade(subjectGrade: subjectGrade);
  }

  String getCurrentSubjectId() {
    return model.currentSubject.getSubjectId();
  }

  Future<String> createSubject(context) async {
    var url = Uri.parse('http://localhost:8080/subject/createSubject');
    var response = await post(url, headers: {
      'contentType': 'application/json',
      'Authorization':
          'Bearer eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoxLCJpYXQiOjE2Mjc2ODEyMTAsImV4cCI6MTYyNzc2NzYxMH0.vqeTH7sNa74lr4wP5IUgWS5s_9y_RgOoVYBkUroA0XtftPHhlDSfrSgHB8UINIfhOsvQ9Y8VCPHbJ66GuD2B1G5aEEcs6ea0zBwYv5XHlOU1elT_S05v9kMuXba6FzXkI4EUvgBVs3zxlCEgpswDLRX7GHsYvXb_9cN-O2pHUVgexB3-F1ZX2tiXKt20wj9HX5wdagm3BcdIrxJTTz2is5OtB2LwvXaT5OH81lIiV9nTLzWW0-JyBd0iU9ux_on01TZ9bxNLmSDt6k_de7P30MV0gDruA1FL6UpQY8zivdkUPnWFecBMRYeZU7EaBBzP1qpvu_uGaTfo0eE252En5BzWEcj1kno1ki0DO7YGfFVQd1gFL8Ez_UekCttqD-Uk86zW6OhHHeiy1dX9yowsNNHyeez2UKjQSznS0NQHPr6HRluEDNxc4gonmdjgo1VbEMWbmw8BQepTurY7_q9uKGH8N2_qSmx_9phL9BiZCYiHDfOe15Ze2lgfnkAohr7WNX-PPTlM8wpCtJZfkfrtXasJ4UWUR0tEz8yOXio4dD9bgS4d1wlOs9yzp04KYj6_Rp9OU5khVImvpQlg24J5lMvJgrmw86qn4e_aJIruDp80PE3z81na6yNsv14JIiofq6F1eFAqKsDuERi2zqYhPuMYZ_4486Cx-7VETH9Z4No',
    }, body: {
      'title': model.viewBoundSubject.getSubjectTitle(),
      'grade': model.viewBoundSubject.getSubjectGrade(),
    });
    if (response.statusCode == 200) {
      MomentumRouter.goto(context, SubjectsView);
      return "Subject Created";
    } else {
      print(response.body);
      return "Subject Could not be created";
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

}
