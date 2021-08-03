import 'package:edugo_web_app/src/Pages/EduGo.dart';

class VirtualEntityStoreView extends StatelessWidget {
  const VirtualEntityStoreView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //* Controller loading virtual entities on build on the VirtualEntityStoreView
    Momentum.controller<VirtualEntityController>(context)
        .getVirtualEntities(context);
    //*
    return MomentumBuilder(
      controllers: [VirtualEntityController],
      builder: (context, snapshot) {
        var entity = snapshot<VirtualEntityModel>();
        return PageLayout(
          child: Stack(
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: Text(
                  "Virtual Entity Store",
                  style: TextStyle(
                    fontSize: 32,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 75),
                child: GridView.count(
                  primary: false,
                  padding: const EdgeInsets.only(
                      right: 30, left: 30, top: 30, bottom: 50),
                  crossAxisSpacing: 40,
                  mainAxisSpacing: 40,
                  crossAxisCount: 4,
                  children: entity.virtualEntityStore,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
