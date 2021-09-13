import 'package:edugo_web_app/src/Pages/EduGo.dart';

class AddEntityStoreCard extends StatelessWidget {
  //Info: Virtual Entities Store Card attributes
  final String name;
  final String virtualEntityDescription;
  final Function addFunction;
  final Function viewFunction;
  final String thumbNailLink;
  final String id;

  AddEntityStoreCard({
    this.id,
    this.name,
    this.virtualEntityDescription,
    this.addFunction,
    this.viewFunction,
    this.thumbNailLink,
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
                          color: Color.fromARGB(255, 97, 211, 87),
                          fontSize: 18),
                    ),
                    onPressed: () {
                      viewFunction(
                          name: name,
                          description: virtualEntityDescription,
                          id: id);
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }
}
