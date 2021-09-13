import 'package:edugo_web_app/src/Pages/EduGo.dart';
import 'package:edugo_web_app/src/Pages/ViewLesson/View/Widgets/AddEntityStoreCard.dart';
import 'package:edugo_web_app/src/Pages/VirtualEntityStore/Model/Data/VirtualEntities.dart';
import 'package:edugo_web_app/src/Pages/VirtualEntityStore/Model/Data/VirtualEntity.dart';
import 'package:edugo_web_app/src/Pages/VirtualEntityStore/View/Widgets/VirtualEntitiesStoreCard.dart';

class VirtualEntityStoreController
    extends MomentumController<VirtualEntityStoreModel> {
  @override
  VirtualEntityStoreModel init() {
    return VirtualEntityStoreModel(this,
        virtualEntities: [],
        virtualEntityCards: [],
        addStore: [],
        addStoreCards: [],
        public: false);
  }

  void changePublic(bool public, context) {
    model.changePublic(public);
    getEducatorVirtualEntityStore(context);
  }

  List<VirtualEntity> getEntities() {
    return model.virtualEntities;
  }

// Info: Get all subjects created by the educator
  Future<void> getEducatorVirtualEntityStore(context) async {
    var url = Uri.parse(model.public
        ? EduGoHttpModule().getBaseUrl() +
            '/virtualEntity/getPublicVirtualEntities'
        : EduGoHttpModule().getBaseUrl() +
            '/virtualEntity/getPrivateVirtualEntities');
    await post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization':
            Momentum.controller<AdminController>(context).getToken()
      },
    ).then((response) {
      if (response.statusCode == 200) {
        model.updateVirtualEntities([]);
        model.updateVirtualEntityCards();
        dynamic _virtualEntities = jsonDecode(response.body);
        model.updateVirtualEntities(
            VirtualEntities.fromJson(_virtualEntities).virtualEntities);
        model.updateVirtualEntityCards();
        return;
      }
    });
  }

  Future getAddStore(context,
      {Function addFunction, Function viewFunction}) async {
    var url = Uri.parse(EduGoHttpModule().getBaseUrl() +
        '/virtualEntity/getPrivateVirtualEntities');
    await post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization':
            Momentum.controller<AdminController>(context).getToken()
      },
    ).then(
      (response) async {
        if (response.statusCode == 200) {
          dynamic _virtualEntities = jsonDecode(response.body);
          model.update(
              addStore:
                  VirtualEntities.fromJson(_virtualEntities).virtualEntities);
          url = Uri.parse(EduGoHttpModule().getBaseUrl() +
              '/virtualEntity/getPublicVirtualEntities');
          await post(
            url,
            headers: {
              'Content-Type': 'application/json',
              'Authorization':
                  Momentum.controller<AdminController>(context).getToken()
            },
          ).then(
            (response) {
              if (response.statusCode == 200) {
                dynamic _virtualEntities = jsonDecode(response.body);
                List<VirtualEntity> copy = model.addStore;
                VirtualEntities.fromJson(_virtualEntities)
                    .virtualEntities
                    .forEach((entity) {
                  copy.add(entity);
                });
                model.update(addStore: copy);
                List<Widget> addCards = [];
                model.addStore.forEach(
                  (entity) {
                    addCards.add(AddEntityStoreCard(
                      id: entity.getVirtualEntityId().toString(),
                      addFunction: addFunction,
                      viewFunction: viewFunction,
                      thumbNailLink: '',
                      name: entity.getVirtualEntityName(),
                      virtualEntityDescription: entity
                          .getVirtualEntityDescription()
                          .toString()
                          .substring(
                              1,
                              entity
                                      .getVirtualEntityDescription()
                                      .toString()
                                      .length -
                                  1),
                    ));
                  },
                );
                model.update(addStoreCards: addCards);
                return;
              }
            },
          );
        }
      },
    );
  }
}
