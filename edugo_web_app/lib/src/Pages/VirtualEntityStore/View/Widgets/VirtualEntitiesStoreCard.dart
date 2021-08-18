import 'package:edugo_web_app/src/Pages/EduGo.dart';

class VirtualEntitiesStoreCard extends StatelessWidget {
  //Info: Virtual Entities Store Card attributes
  final String name;
  final int virtualEntityId;

  VirtualEntitiesStoreCard({
    this.name,
    this.virtualEntityId,
  });

  @override
  Widget build(BuildContext context) {
    //Info: Virtual Entities Store Card user interface
    return Card(
      elevation: 40,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      shadowColor: Colors.green,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              title: Column(
                children: [
                  Icon(
                    Icons.view_in_ar_outlined,
                    size: 60,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Align(
                      alignment: Alignment.center,
                      child: Text(name, style: TextStyle(fontSize: 22))),
                ],
              ),
              subtitle: Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Align(
                    alignment: Alignment.center,
                    // child: Text('Entity by: Mr TN Mafaralala'),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
            TextButton(
              child: const Text(
                'View Entity',
                style: TextStyle(
                    color: Color.fromARGB(255, 97, 211, 87), fontSize: 18),
              ),
              onPressed: () {
                // updateVirtualEntityName("Mish the Astronaut");
                // MomentumRouter.goto(context, ViewVirtualEntityView);
              },
            ),
          ],
        ),
      ),
    );
  }
}
