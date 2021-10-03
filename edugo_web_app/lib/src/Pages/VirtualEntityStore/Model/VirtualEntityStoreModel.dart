import 'package:edugo_web_app/src/Pages/EduGo.dart';
import 'package:edugo_web_app/src/Pages/VirtualEntityStore/Model/Data/VirtualEntity.dart';
import 'package:edugo_web_app/src/Pages/VirtualEntityStore/View/Widgets/VirtualEntitiesStoreWidgets.dart';

class VirtualEntityStoreModel
    extends MomentumModel<VirtualEntityStoreController> {
  final List<VirtualEntity> virtualEntities;
  final List<Widget> virtualEntityCards;
  final List<Widget> addStoreCards;
  final List<VirtualEntity> addStore;
  final bool public;

  VirtualEntityStoreModel(VirtualEntityStoreController controller,
      {this.virtualEntities,
      this.virtualEntityCards,
      this.addStoreCards,
      this.public,
      this.addStore})
      : super(controller);

// Info: Update list of Virtual Entities
  void updateVirtualEntities(List<VirtualEntity> virtualEntitiesUpdate) {
    update(virtualEntities: virtualEntitiesUpdate);
  }

// Info: Update Virtual Entity cards
  void updateVirtualEntityCards() {
    List<Widget> virtualEntityCardsUpdate = [];
    virtualEntities.forEach(
      (virtualEntity) {
        virtualEntityCardsUpdate.add(new VirtualEntitiesStoreCard(
          name: virtualEntity.getVirtualEntityName(),
          virtualEntityId: virtualEntity.getVirtualEntityId(),
          public: virtualEntity.getPublic(),
          thumbNail: virtualEntity.getThumbNail(),
          virtualEntityDescription: virtualEntity
              .getVirtualEntityDescription()
              .toString()
              .substring(
                  1,
                  virtualEntity
                          .getVirtualEntityDescription()
                          .toString()
                          .length -
                      1),
        ));
      },
    );
    if (virtualEntities.isEmpty) {
      virtualEntityCardsUpdate.add(Text('No Entities'));
    }
    update(virtualEntityCards: virtualEntityCardsUpdate);
  }

  void changePublic(bool public) {
    update(public: public);
  }

  @override
  void update(
      {List<VirtualEntity> virtualEntities,
      List<Widget> virtualEntityCards,
      List<VirtualEntity> addStore,
      List<Widget> addStoreCards,
      bool public}) {
    VirtualEntityStoreModel(controller,
            virtualEntities: virtualEntities ?? this.virtualEntities,
            virtualEntityCards: virtualEntityCards ?? this.virtualEntityCards,
            public: public ?? this.public,
            addStore: addStore ?? this.addStore,
            addStoreCards: addStoreCards ?? this.addStoreCards)
        .updateMomentum();
  }
}
