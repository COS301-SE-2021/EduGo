import 'package:edugo_web_app/src/Pages/EduGo.dart';

class EducatorVirtualEntitiesView extends StatelessWidget {
  const EducatorVirtualEntitiesView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // //* Controller loading virtual entities on build on the VirtualEntityStoreView
    // Momentum.controller<VirtualEntityApiController>(context).getVirtualEntities(
    //     context); //Todo :  implement a variation of this function that gets allvirtual entities associated with an educator ID
    // //*
    return MomentumBuilder(
      controllers: [VirtualEntityApiController],
      builder: (context, snapshot) {
        var entity = snapshot<VirtualEntityApiModel>();
        return PageLayout(
          top: 0,
          left: 0,
          right: 0,
          child: Stack(
            children: [
              Container(
                padding: EdgeInsets.only(top: 0),
                child: ListView(
                  padding: const EdgeInsets.only(
                    top: 50,
                  ),
                  children: [
                    Align(
                      alignment: Alignment.topCenter,
                      child: Material(
                        borderRadius: BorderRadius.circular(10),
                        elevation: 40,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 97, 211, 87),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: EdgeInsets.symmetric(
                              horizontal: 70, vertical: 20),
                          child: Text(
                            "Created Virtual Entities",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 32,
                            ),
                          ),
                        ),
                      ),
                    ),
                    GridView.count(
                      physics: NeverScrollableScrollPhysics(),
                      primary: false,
                      shrinkWrap: true,
                      padding: const EdgeInsets.only(
                          right: 30, left: 30, top: 50, bottom: 80),
                      crossAxisSpacing: 40,
                      mainAxisSpacing: 40,
                      crossAxisCount: 4,
                      children: [],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
