import 'package:edugo_web_app/src/Pages/EduGo.dart';

class VirtualEntitiesStoreCard extends StatelessWidget {
  //Info: Virtual Entities Store Card attributes
  final String name;
  final int virtualEntityId;
  final String virtualEntityDescription;
  final bool public;
  final String thumbNail;

  VirtualEntitiesStoreCard({
    this.name,
    this.public,
    this.virtualEntityId,
    this.thumbNail,
    this.virtualEntityDescription,
  });

  @override
  Widget build(BuildContext context) {
    //Info: Virtual Entities Store Card user interface
    return MomentumBuilder(
        controllers: [ViewVirtualEntityController],
        builder: (context, snapshot) {
          return Card(
            elevation: 40,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0)),
            shadowColor: Colors.green,
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(5.0),
                      topRight: Radius.circular(5.0),
                    ),
                    child: Image.network(
                      thumbNail,
                      width: 400,
                      height: 150,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  TextButton(
                    child: const Text(
                      'View Entity',
                      style: TextStyle(
                          color: Color.fromARGB(255, 97, 211, 87),
                          fontSize: 18),
                    ),
                    onPressed: () {
                      Momentum.controller<ViewVirtualEntityController>(context)
                          .reset();
                      Momentum.controller<ViewVirtualEntityController>(context)
                          .viewEntity(name, virtualEntityDescription,
                              virtualEntityId.toString(), public, context);

                      MomentumRouter.goto(context, ViewVirtualEntityView);
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }
}
