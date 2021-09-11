import 'package:edugo_web_app/src/Pages/EduGo.dart';

class VirtualEntitySelectorCard extends StatelessWidget {
  final String title;
  final String link;

  VirtualEntitySelectorCard({this.title, this.link});

  @override
  Widget build(BuildContext context) {
    //Info: Virtual Entity Selector Card
    return Container(
      margin: EdgeInsets.only(bottom: 50),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50.0),
        child: Card(
          elevation: 50,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          shadowColor: Color.fromARGB(255, 97, 211, 87),
          color: Colors.white,
          child: Row(
            children: <Widget>[
              Container(
                child: Column(children: [
                  Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      title,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      softWrap: false,
                      style: TextStyle(
                        fontSize: 25,
                      ),
                    ),
                  ),
                  //*
                ]),
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
    );
  }
}
