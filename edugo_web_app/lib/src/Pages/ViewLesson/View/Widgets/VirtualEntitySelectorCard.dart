import 'package:edugo_web_app/src/Pages/EduGo.dart';

class VirtualEntitySelectorCard extends StatelessWidget {
  final String title;
  final String link;

  VirtualEntitySelectorCard({this.title, this.link});

  @override
  Widget build(BuildContext context) {
    //Info: Virtual Entity Selector Card
    return MomentumBuilder(
        controllers: [ViewLessonController],
        builder: (context, snapshot) {
          return GestureDetector(
            onTap: () {
              Momentum.controller<ViewLessonController>(context)
                  .setCurrentEntityImage(imageLink: link);
            },
            child: MouseRegion(
              cursor: SystemMouseCursors.click,
              child: Container(
                height: 80,
                margin: EdgeInsets.only(bottom: 30),
                child: Card(
                  elevation: 50,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  shadowColor: Color.fromARGB(255, 97, 211, 87),
                  color: Colors.white,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 40.0),
                    child: Row(
                      children: <Widget>[
                        Text(
                          title,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          softWrap: false,
                          style: TextStyle(
                            fontSize: 25,
                          ),
                        ),
                        Spacer(),
                        Icon(
                          Icons.view_in_ar_outlined,
                          color: Color.fromARGB(255, 97, 211, 87),
                          size: 35,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        });
  }
}
